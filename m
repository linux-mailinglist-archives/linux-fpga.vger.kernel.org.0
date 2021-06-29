Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1623B7194
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhF2LwP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 07:52:15 -0400
Received: from mail-db8eur05on2136.outbound.protection.outlook.com ([40.107.20.136]:17633
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232535AbhF2LwO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 07:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evFiWljSj+G4kwd4PEV0808GS3SP/oLDtcQeREb7Qw/vTWySdHA8mYCk26JMMI8k0i9mAr4oAemHsxvVdNpf+vTJOMJKu7lqqZA1YHIZeYT43cwlAtj3H9cxRo+4Q3guBIL8dxYG1iHRQezpKV4OGmxJLKYvWPGsM5lB+CsTKRNYPlTz+bwKqkf2cNbTP446TF0VI5lpSG5Wg3giU2Oh+5EFq+el4i2EBi0tmXURN2hdzETQBFnj3ozXVyq67NH6Hc926Du73E2TzFLUyQMRAuYFjEhR5TVdB/5A5ujXA1MAkY+VGyylhRvT4CeTyskdYyIIwIrnMDhDeR8Yga9OYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqNdqN7i36zzbGzER0UaO3lt27VPegwUfu1LC9jnOSk=;
 b=IxLf8TOx/2bdZqKq3Ad6g5rWzp5zfcCvPZEijNvom9TEQhHsKnEiCF6Y0oVnLhdfLACURF3cPJqiV1GL0xiGhwveQ5/MQpWWlad6wCPnN/P6wP9jSf2PASUm/kPjF3JMx6dBS384tdNyPCCLJyuR61ePTRwGFwQkp98mVZDbzLqtvBalKxbOnGfMBE/nsP11zh+6EMXiX6gBlbjoyke7HFyAh0ye8tytz0FcAvKXf9YPA4DoXRN7XZL4foa9y1q1cOijtGTe4/DpfEhhkJDc8wVslxBm/d4VUMs7EapB6Uxn4+GmdsDM0YcYgkNZSuSFDJdtCjn1BhvQtLcIlHy/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqNdqN7i36zzbGzER0UaO3lt27VPegwUfu1LC9jnOSk=;
 b=E5N3Ha6KaKPaOGCQkYItdSMzLDz6ByFSc7Lx6PMsF+PHA8ezBRFjQnGxkVsr+pCeN8QTwSQ4SqNczrNCI64Uo+ErUpwjJt0u3BE73JUrYqUL7r27R22TN/PZzi56N0eyx3atkJuL5FXIMBaGywgCnWId1mrL9CEd3/Da+ImuTxg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB4452.eurprd04.prod.outlook.com
 (2603:10a6:208:71::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.22; Tue, 29 Jun
 2021 11:49:45 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 11:49:45 +0000
Subject: Re: [PATCH v2 3/5] spi: spi-altera-dfl: support n5010 feature
 revision
To:     Moritz Fischer <mdf@kernel.org>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-4-martin@geanix.com> <YNoJSxnm4g1vufbB@epycbox.lan>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <e4f0b534-903c-c95d-876e-389c8fc4852c@silicom.dk>
Date:   Tue, 29 Jun 2021 13:49:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YNoJSxnm4g1vufbB@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Tue, 29 Jun 2021 11:49:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1b56b8-3d15-4d10-e057-08d93af3fd82
X-MS-TrafficTypeDiagnostic: AM0PR04MB4452:
X-Microsoft-Antispam-PRVS: <AM0PR04MB44529D54C87127F83D7D92E5D5029@AM0PR04MB4452.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+yey3akiZBIQdFFo2H1thMYEeYGy/fhNUsEKzN9FEsw7C2hcOFV+/RPAyUyvIKn+r94ZkcGUAfsS4dpFgEFp5J4H7qICCbUANUyljUTozeaUMiSzfi9jOYBmvv6zre5u2otU0G5+rxi4+GScZMS3retx+hZaKAPtLugOqvqBjtt3z0MVAV3JTrFPu+kTtOSv6ZxAPNNItkWeBFZbjCa2PJSHSPdXEMuPXBpQkox6pQAloBtq6c3sebwRZAUwiI9/AZhOYGCaJa3NaVdi938TfOOcjo/RxpwkCeD7Q7m1QpVLsK7g518/w/DreUY1f3eaquAsytV3xURd37Oz7k40T4UntVgtAGFk4o3fSRZGzI/8P2f8u6tyMzpfQBvMCIOr4ofA44ekdY6m6Yq7LkbToKNZOsXa3o1UBQMVSXohNaU18GK3DDhr+qr10VxU4tzionX3wceWrwumD5UQsDrfvevYnWh6yTYapdLo3HJ+++iI83wnobiYQRkvz1X4kh5Wt33E+Z+sVL5IwBpb7nHrR2+s87q4zpGs9ROMBvFbhtmJegVpu5eHXVjK7Aca5pOO/157Mn8DPLxIbaA/gbxT4VBwdlMAPPMsHzzCFR8EZRL1G3rawyJTmQtDP3yDnPhQhA6/fbwIOZPDFMZBdsbfUPBHvrejliMzqhLQ3mhKeeK6BUXuKZD8qpge5QNxf9pT0+Rhvk7VglnCwN/tIWkurxdFm8ce10/EzSCaGAEkbhyNC433bjz7LMfLjw4o+op
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(366004)(376002)(396003)(66556008)(66476007)(6486002)(66946007)(8676002)(83380400001)(7416002)(186003)(26005)(16526019)(4326008)(38100700002)(8936002)(2616005)(8976002)(956004)(110136005)(54906003)(5660300002)(86362001)(31696002)(36756003)(66574015)(478600001)(316002)(2906002)(16576012)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFLV2FqVFVtdms0UngwaC9Na2tKS084Y2x1Tloxb001ODdvS2Q5ZTV4bDhE?=
 =?utf-8?B?SXphdXE5aWdUZldLek1ZK3R2T3E4L2xPdlV5ejNyVkVxZTdueU1TZGZSSFM0?=
 =?utf-8?B?bGJjek5OdkRDRjg3aGRIRzNteGNOcUhVdE5DakRtWGJmdlV6YWI5ZDVlRHpP?=
 =?utf-8?B?TEk3eWVsejZEUVpBM0NRdExDZnppaHZvRTlLVE92TjUydjJrbmJhWUJaY2cy?=
 =?utf-8?B?dmh1VVVZZWpDSlM2MEY0L0ZWcjBUZkFVMVhBRkNFclRKSGZQd1lxQmxOZ2h4?=
 =?utf-8?B?Wmtxc1B3dUVVaE53amhWRDBDM25jeWFtZ0p5cDVDWkI0cUdwWVExSURyOVFY?=
 =?utf-8?B?NnlTeTN2MGJiKzhyd3N1RlVOaGFGTlVhMi9ISHAvVnZMaWNidURqUGl5a3c1?=
 =?utf-8?B?QUJSdERiVmVCN0xuS0o1UXpnbHlVdmhnNEREVmhmYTlEcGFBSjUxaFhEMndn?=
 =?utf-8?B?Wm0rN1hqdTBEZ3J3SVlMNjZaNlBEOWNldUFjUGEzbkZlazBDRVhjMHNzOHpy?=
 =?utf-8?B?c3h4RmlCdHYyWmszM2xKSEtCdkdhWFcvM1hid1lJMjdwMUlLVWZ6RWhFUUlO?=
 =?utf-8?B?cWx2cVR0VmllbElRQ0tHSnoyRjRlZU1IY2R2aEpQMlBUck9CejIzTDlDKzJE?=
 =?utf-8?B?QUZQMmVUQlA3aVFlWThLQVJHSDNKTVF1MmVLTlQzWk5BeHFFZnB6UytQZ0dZ?=
 =?utf-8?B?Z3lHTUJNM1FOTmgyQXoyN2ZjcEg5L0twUnViK01pRlhQMWtpQmFkUXVod2d5?=
 =?utf-8?B?aDZJZVpwd01xVTE1ZkFqVzc5LzBHWkxwN0dEcnFKK0VlcjlPWHVWRmZnSnNs?=
 =?utf-8?B?TG5IVHBHb2dKOHhFc253SitlbEhoVXRXdjNGUUhZeXhHUHo4SUR3dVJYRGho?=
 =?utf-8?B?NWEzWWF5U1JzTmVXMmx5UndBWkJ6S3EyTklpU0ZsYmJucXBEOUc4U2xzbGtR?=
 =?utf-8?B?TUVKTnd0R2VtSFZNMzc5a1FsT0xlSW1uMVRlWHl4RTNhZ09pWUVQamZmTnhn?=
 =?utf-8?B?RktlTmtUOVJrZVdyc0lkWWtTTHZzRTMvTWlvTWFzb0tKZ2FFYzBTeGlOMncz?=
 =?utf-8?B?WjN6NGNESjlqMnlRUVJONFIwZXMzL1YwbjhERkFFOXRDWHR4MDN1UXRBSGY0?=
 =?utf-8?B?NlhvcS9lWTJIWndkSThYTWd5ck1IYnJBSkJUbGxMNUFwaW4zTjV0VXF6RXEr?=
 =?utf-8?B?QjIwbk9pN09WRFNPUHdjUjdzZHF0SVlJMXREK1NyZzBONXZkRFYrRmR2VEFR?=
 =?utf-8?B?eGU4MEcyRm11NzhqdUxkZjZUV0lLVFp0bkx4dlAvcGVTR0w3U1J0S1duNEU3?=
 =?utf-8?B?Ykh0Sy9SS1EvUThxLzlSUU1PYXlzRGNjRFl5VDlzb1BQRnQ3NHBQU0FLZ0NR?=
 =?utf-8?B?VllWaXVJeGMxaVJ2VHFpb0x4LzNmM3ZsWWpPbEdKbVR0b2VjZ1RCK3RxQlpq?=
 =?utf-8?B?aFJTVE5ZZlJpZzlSTzFYOVlGM1F1M1BlUFJHMWh5QXlqTFdKa2lVSU9Gd0Vv?=
 =?utf-8?B?QlBFdkJKb0QvNkUxY09CSXREcU9uRmUrRHhNQ3V6WVRjOWJHN3JlM0dBTmxE?=
 =?utf-8?B?YmE5eU9kM0ZVTkFDNnlSSEE5N3dNWmIzdHhtR3hUbHpGa1p5WTE1RXUxbE5r?=
 =?utf-8?B?SmJvdVcxKzl4KzczdG5HUndTdENnMGVQby8vZFM2ZFBVMkJLSU84OVdXNlo1?=
 =?utf-8?B?M0xuMEROT05LVWNVOVgrTDJCcHpuMEg3aGtkSHQ2VXlhUHhpUUZEOU9WQkRm?=
 =?utf-8?Q?087nkZ5KADs2EQq1J+E8K3jGCPhXPQX+PX3/+ZH?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1b56b8-3d15-4d10-e057-08d93af3fd82
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 11:49:45.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uXWEfJ3fUbGphY/kAMG9Wmv/aEZ4ObQKD2jArHRZ0Zn7jpWX9LwIp66Zr0jZ2Mj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4452
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 28/06/2021 19.39, Moritz Fischer wrote:
> On Fri, Jun 25, 2021 at 09:42:11AM +0200, Martin Hundebøll wrote:
>> From: Martin Hundebøll<mhu@silicom.dk>
>>
>> The Max10 BMC on the Silicom n5010 PAC is slightly different than the
>> existing BMC's, so use a dedicated feature revision detect it.
>>
>> Signed-off-by: Martin Hundebøll<mhu@silicom.dk>
>> ---
>>
>> Changes since v1:
>>   * use feature revision from struct dfl_device instead of reading it
>>     from io-mem
>>
>>   drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
>> index 3e32e4fe5895..f6cf7c8d9dac 100644
>> --- a/drivers/spi/spi-altera-dfl.c
>> +++ b/drivers/spi/spi-altera-dfl.c
>> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>>   	.chip_select = 0,
>>   };
>>   
>> +static struct spi_board_info m10_n5010_bmc_info = {
>> +	.modalias = "m10-n5010",
>> +	.max_speed_hz = 12500000,
>> +	.bus_num = 0,
>> +	.chip_select = 0,
>> +};
> Is there no way to query the mc for version info?

Do you mean reading the BMC variant (i.e. n5010 / d5005 / n3000) from a
register?

Not in a uniform way across the different boards that I'm aware of. But
isn't this what the DFL feature revision is meant for?

// Martin
