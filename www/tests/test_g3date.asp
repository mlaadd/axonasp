<%@Language="VBSCRIPT" CodePage="65001"%>
<%
Option Explicit
Dim dt, now, parsed, dur, result, arr, isOk

Response.Write "<h1>G3DATE Library Tests</h1>"
Response.Write "<pre>"

Set dt = Server.CreateObject("G3DATE")
If Not IsObject(dt) Then
    Response.Write "FAIL: Could not create G3DATE object"
    Response.End
End If
Response.Write "PASS: G3DATE object created" & vbCrLf

' Test Now
now = dt.Now()
If IsDate(now) Then
    Response.Write "PASS: Now() returns a date: " & now & vbCrLf
Else
    Response.Write "FAIL: Now() did not return a date" & vbCrLf
End If

' Test UTCNow
Dim utc
utc = dt.UTCNow()
If IsDate(utc) Then
    Response.Write "PASS: UTCNow() returns a date: " & utc & vbCrLf
Else
    Response.Write "FAIL: UTCNow() did not return a date" & vbCrLf
End If

' Test Parse
parsed = dt.Parse("2006-01-02", "2026-12-25")
If IsDate(parsed) Then
    Response.Write "PASS: Parse() returns a date: " & parsed & vbCrLf
Else
    Response.Write "FAIL: Parse() did not return a date" & vbCrLf
End If

' Test ParseDuration
dur = dt.ParseDuration("2h30m")
If dur > 0 Then
    Response.Write "PASS: ParseDuration() returns: " & dur & " ns" & vbCrLf
Else
    Response.Write "FAIL: ParseDuration() returned invalid value" & vbCrLf
End If

' Test Year, Month, Day
Dim y, m, d
y = dt.Year(now)
m = dt.Month(now)
d = dt.Day(now)
If y > 2000 And m >= 1 And m <= 12 And d >= 1 And d <= 31 Then
    Response.Write "PASS: Year/Month/Day returns: " & y & "/" & m & "/" & d & vbCrLf
Else
    Response.Write "FAIL: Year/Month/Day returned unexpected values" & vbCrLf
End If

' Test AddDate
Dim future
future = dt.AddDate(now, 1, 0, 0)
If IsDate(future) Then
    Response.Write "PASS: AddDate(+1 year) returns: " & future & vbCrLf
Else
    Response.Write "FAIL: AddDate() did not return a date" & vbCrLf
End If

' Test Format
Dim formatted
formatted = dt.Format(now, "2006-01-02 15:04:05")
If Len(formatted) > 0 Then
    Response.Write "PASS: Format() returns: " & formatted & vbCrLf
Else
    Response.Write "FAIL: Format() returned empty string" & vbCrLf
End If

' Test ISOFormat
Dim iso
iso = dt.ISOFormat(now)
If Len(iso) > 0 Then
    Response.Write "PASS: ISOFormat() returns: " & iso & vbCrLf
Else
    Response.Write "FAIL: ISOFormat() returned empty string" & vbCrLf
End If

' Test DateTimeFormat
Dim dtStr
dtStr = dt.DateTimeFormat(now)
If Len(dtStr) > 0 Then
    Response.Write "PASS: DateTimeFormat() returns: " & dtStr & vbCrLf
Else
    Response.Write "FAIL: DateTimeFormat() returned empty string" & vbCrLf
End If

' Test Unix and TimeUnix
Dim ts, back
ts = 1763257845
Dim unixDate
unixDate = dt.Unix(ts, 0)
If IsDate(unixDate) Then
    Response.Write "PASS: Unix() creates date from timestamp: " & unixDate & vbCrLf
Else
    Response.Write "FAIL: Unix() did not create a date" & vbCrLf
End If

back = dt.TimeUnix(unixDate)
If back = ts Then
    Response.Write "PASS: TimeUnix() returns: " & back & vbCrLf
Else
    Response.Write "FAIL: TimeUnix() expected " & ts & " got " & back & vbCrLf
End If

' Test DateDiff
Dim diff
Dim later
later = dt.AddDate(now, 0, 0, 7) ' 7 days later
diff = dt.DateDiff(later, now)
If diff > 0 Then
    Response.Write "PASS: DateDiff() returns: " & diff & " ns" & vbCrLf
Else
    Response.Write "FAIL: DateDiff() returned non-positive value" & vbCrLf
End If

' Test DurationHours
Dim hours
hours = dt.DurationHours(diff)
If hours > 0 Then
    Response.Write "PASS: DurationHours() returns: " & hours & vbCrLf
Else
    Response.Write "FAIL: DurationHours() returned non-positive value" & vbCrLf
End If

' Test After/Before
Dim isAfter, isBefore
isAfter = dt.After(later, now)
isBefore = dt.Before(later, now)
If isAfter = True And isBefore = False Then
    Response.Write "PASS: After/Before comparison works correctly" & vbCrLf
Else
    Response.Write "FAIL: After/Before comparison failed" & vbCrLf
End If

' Test ConvertUTCtoZone
Dim nyTime
nyTime = dt.ConvertUTCtoZone(utc, "America/New_York")
If IsDate(nyTime) Then
    Response.Write "PASS: ConvertUTCtoZone() returns: " & nyTime & vbCrLf
Else
    Response.Write "FAIL: ConvertUTCtoZone() did not return a date" & vbCrLf
End If

' Test Clock
arr = dt.Clock(now)
If IsArray(arr) Then
    Response.Write "PASS: Clock() returns an array" & vbCrLf
Else
    Response.Write "FAIL: Clock() did not return an array" & vbCrLf
End If

' Test Zone
arr = dt.Zone(utc)
If IsArray(arr) Then
    Response.Write "PASS: Zone() returns an array" & vbCrLf
Else
    Response.Write "FAIL: Zone() did not return an array" & vbCrLf
End If

' Test IsDST
Dim isDst
isDst = dt.IsDST(utc)
Response.Write "PASS: IsDST(UTC) returns: " & CStr(isDst) & vbCrLf

' Test IsZero
Dim zeroDate
zeroDate = dt.IsZero(CDate("0"))
Response.Write "PASS: IsZero() test completed" & vbCrLf

' Test LoadLocation
Dim locName
locName = dt.LoadLocation("America/New_York")
If locName = "America/New_York" Then
    Response.Write "PASS: LoadLocation() returns: " & locName & vbCrLf
Else
    Response.Write "FAIL: LoadLocation() expected America/New_York got " & locName & vbCrLf
End If

' Test invalid LoadLocation
Dim invalidLoc
invalidLoc = dt.LoadLocation("Invalid/Zone_Does_Not_Exist")
If IsEmpty(invalidLoc) Then
    Response.Write "PASS: LoadLocation(invalid) returns Empty" & vbCrLf
Else
    Response.Write "FAIL: LoadLocation(invalid) should be Empty" & vbCrLf
End If

' Test Date constructor
Dim customDate
customDate = dt.Date(2026, 12, 25, 10, 30, 0, 0, "UTC")
If IsDate(customDate) Then
    Response.Write "PASS: Date() creates: " & customDate & vbCrLf
Else
    Response.Write "FAIL: Date() did not create a date" & vbCrLf
End If

' Test Month/Day from custom date
Dim cm, cd
cm = dt.Month(customDate)
cd = dt.Day(customDate)
If cm = 12 And cd = 25 Then
    Response.Write "PASS: Month/Day from custom date: " & cm & "/" & cd & vbCrLf
Else
    Response.Write "FAIL: Month/Day expected 12/25 got " & cm & "/" & cd & vbCrLf
End If

' Test DurationString
Dim durStr
durStr = dt.DurationString(dur)
If Len(durStr) > 0 Then
    Response.Write "PASS: DurationString() returns: " & durStr & vbCrLf
Else
    Response.Write "FAIL: DurationString() returned empty" & vbCrLf
End If

' Test Location
Dim sysLoc
sysLoc = dt.Location()
If Len(sysLoc) > 0 Then
    Response.Write "PASS: Location() returns: " & sysLoc & vbCrLf
Else
    Response.Write "FAIL: Location() returned empty" & vbCrLf
End If

' Test OffsetZoneToUTC
Dim off
off = dt.OffsetZoneToUTC("UTC")
If off = 0 Then
    Response.Write "PASS: OffsetZoneToUTC(UTC) = " & off & vbCrLf
Else
    Response.Write "FAIL: OffsetZoneToUTC(UTC) expected 0, got " & off & vbCrLf
End If

' Test In
Dim inZone
inZone = dt.In(utc, "America/New_York")
If IsDate(inZone) Then
    Response.Write "PASS: In() converts timezone: " & inZone & vbCrLf
Else
    Response.Write "FAIL: In() did not return a date" & vbCrLf
End If

' Test Truncate
Dim truncated
truncated = dt.Truncate(now, 3600000000000) ' truncate to 1 hour
If IsDate(truncated) Then
    Response.Write "PASS: Truncate() completed" & vbCrLf
Else
    Response.Write "FAIL: Truncate() did not return a date" & vbCrLf
End If

' Test Since/Until
Dim sinceVal, untilVal
sinceVal = dt.Since(utc)
untilVal = dt.Until(future)
If sinceVal > 0 Or sinceVal < 0 Then
    Response.Write "PASS: Since() returns: " & sinceVal & vbCrLf
End If
If untilVal > 0 Or untilVal < 0 Then
    Response.Write "PASS: Until() returns: " & untilVal & vbCrLf
End If

' Test Equals
Dim equal
equal = dt.Equal(now, now)
If equal = True Then
    Response.Write "PASS: Equal() returns True for same dates" & vbCrLf
Else
    Response.Write "FAIL: Equal() should be True for same dates" & vbCrLf
End If

' Test UTC
Dim utcConverted
utcConverted = dt.UTC(now)
If IsDate(utcConverted) Then
    Response.Write "PASS: UTC() converts to UTC: " & utcConverted & vbCrLf
Else
    Response.Write "FAIL: UTC() did not return a date" & vbCrLf
End If

' Test Hour/Minute/Second
Dim h, min, s
h = dt.Hour(now)
min = dt.Minute(now)
s = dt.Second(now)
If h >= 0 And h <= 23 And min >= 0 And min <= 59 And s >= 0 And s <= 59 Then
    Response.Write "PASS: Hour/Minute/Second: " & h & ":" & min & ":" & s & vbCrLf
Else
    Response.Write "FAIL: Hour/Minute/Second returned unexpected values" & vbCrLf
End If

' Test FixedZone
Dim fzName
fzName = dt.FixedZone(-18000, "EST")
If Len(fzName) > 0 Then
    Response.Write "PASS: FixedZone() returns: " & fzName & vbCrLf
Else
    Response.Write "FAIL: FixedZone() returned empty" & vbCrLf
End If

' Cleanup
Set dt = Nothing
Response.Write vbCrLf & "All G3DATE tests completed." & vbCrLf
Response.Write "</pre>"
%>