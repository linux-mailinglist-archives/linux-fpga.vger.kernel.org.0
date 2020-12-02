Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062BC2CBE98
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 14:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgLBNlo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 08:41:44 -0500
Received: from mail-eopbgr80127.outbound.protection.outlook.com ([40.107.8.127]:5383
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbgLBNlo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Dec 2020 08:41:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUifoG6xFyea5yVvJwEOVq0IcS9UFT2YZ5Ivkawa2LXQyRr0dut3g1zxuN8sQQYwaBzrbUY1BDU0cvcwF8WblzizXtYsxeMHDQjS1GHry7NJVlozdLXTs+G81ECJd2+xkNV613CSsS219P5gVmYgUSF+g3AxDsY6WtqwYIGtVIL14NL4XKMhQL8wvsgmJ4o4nURUw500zio39xATIN/G0yy67NJR+2Nlwgp2BgiONQBdd6ECwmfBy/JRVWtOeCWsFqERy0VEUdhnHGpx4GT9HEC+n5s8/iy7LpZMvGHubRhZvh/VaLGnqMWRQOCGr6uOwzyZY498K5PXvB/fZehrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Ke+lSNgrjd6vSkVpxsE8UbAjPAX/6CF8sST34iigU=;
 b=AUFbLzWsaK0iZ/poAJ1j2KmWHpsKIOqZRkkhaos9031LcDW5QyaN8usEr9afyc+qjVK8JgqWMJHLUzsUCRdV7JrbUOFAleI6WmQjrr7R1kuC2P5ujUwbsqcj3K8GmypdbgiJGhjAVCiqBst+2dX3Y5L5a3Yh6tJ0Ke35Gtkp1KerWsbqkORIb5MvrQmFQts2cNeNSX5mFXWbRiktf7NTMdo7vUo7RraoqisQEcGIiDCg10Rbxnu4HWitkac4kbyf4TFoYjjB34SBufUR6AucFbHl+la7Wq5mALnLk+2p2b1xLAQiGyvHw/AV0a1zd98uJGQbKXWcLWdW4SgsdyCf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Ke+lSNgrjd6vSkVpxsE8UbAjPAX/6CF8sST34iigU=;
 b=GBjtTWGhMUc3QWSSO0/tP4xSEgRzL3Bx4ye8j6iBBemyHr17XRkdbq61/+QI6PJbJ4Wxkl4fq1M3x9zaScVI+H9qGHDYTP1OKz2Hc+24l/6lgFVPXsKVXftobDHXxAJeTdNJ5/HlEY24dg5Dp1bpA6RrZkacqDqWWO1/iSQdqUU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM4PR0401MB2340.eurprd04.prod.outlook.com
 (2603:10a6:200:53::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 2 Dec
 2020 13:40:55 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::bdca:6651:1054:423b]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::bdca:6651:1054:423b%5]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 13:40:54 +0000
Subject: Re: [PATCH v6 2/7] fpga: sec-mgr: enable secure updates
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201106010905.11935-1-russell.h.weight@intel.com>
 <20201106010905.11935-3-russell.h.weight@intel.com>
 <9dd75daf-eb73-4008-ca65-6f7ea3923e35@silicom.dk>
 <c6dc2edb-9639-9c4f-c065-18cade768fb6@intel.com>
 <5b49ef38-2c03-02bc-6a1e-5b663180acf3@silicom.dk>
 <25ee1ab1-3d81-d9b9-240d-143a9936d0f8@intel.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <d9be1ac7-3a44-dca0-c989-49c672e21b85@silicom.dk>
Date:   Wed, 2 Dec 2020 14:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <25ee1ab1-3d81-d9b9-240d-143a9936d0f8@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM7PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::37) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM7PR02CA0027.eurprd02.prod.outlook.com (2603:10a6:20b:100::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 13:40:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bfeecf7-3f40-4751-120e-08d896c7e433
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2340:
X-Microsoft-Antispam-PRVS: <AM4PR0401MB23409AEEB8E4542B08FC60EFD5F30@AM4PR0401MB2340.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoSL+UkIX6fytObqZq2SCQ1Wl81zzD4JHPMA9jaD4jwPrJSRyaY9sa7NtJb0sOVVkdtwSyXyRzvzf9u2J1n9474ZnK/6qA6AzlEe4J3mhrxtuioeFNmTDclMXnuh+4vgAnSrou8dWC8bcYXaqoqg0hxt64Hb0t5H3H8JAUssOiDEDv6O8g/JXIwlyJjhAho+YSBCO9tetdlDaXdzfr/mqQd8h2u2DdB2c8tkOjirm4D2sML5jrb6vsalkD1fYBsR1Ki6/cKZRJh+q3lYYs2BLcvn2VpDf7I8YDYw0N89RzrgrayiL85mIYv50XaRO0YgaeWlsvxNaETinXVaBsaElRHQrQFl8l6xBAs+kMv2FOv7qA7O4M1k1HKbcEMIQEURuBPPsDdTBerDbO1GUNKGbDzFfSlpRYMBrSixNsthIhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39850400004)(66556008)(31696002)(5660300002)(66946007)(66476007)(31686004)(956004)(16576012)(316002)(86362001)(36756003)(186003)(66574015)(53546011)(4326008)(2616005)(2906002)(83380400001)(26005)(8936002)(15650500001)(8976002)(8676002)(478600001)(52116002)(16526019)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a25jUTV1c1MxNGdIdDdzV255Tmg0a2JCMnozbVM0UWNIcDFLZ29HK1dpa2F1?=
 =?utf-8?B?Z20vQ3dwQ3V2dVQ4ckJMOVQ3aWJISVo2WG9ZM2gxR3NxUG9UYXYydWx5dzNs?=
 =?utf-8?B?NXRsREdiUU5JbldlaUR0VFNCeTRPbTlFUCtWNHIvcnpSOXhlT0ZicjVqb3ZI?=
 =?utf-8?B?b1FUUHpRK0EwbmowUE4wWVYrUTkwRlFlTTFFUUhieGlkOU5TZi9wcGtsaFJB?=
 =?utf-8?B?TkFJV0F4RThVVTNudDIrQkRRZVhvYkQ2cmZzSUVBajg2Z0srVXN2Z2xPRDZE?=
 =?utf-8?B?eEFzQTdZRDJ1dkFHZVZCUkhPS1NxMFVtcWkxKzlndkxZWW5nK3ZyLzNURTJ0?=
 =?utf-8?B?eWtOQnV4b2NyMUZxMnRVYTR4cWZkaVVhNWYxTmJnR01qbEZYZGtSQ1R0emZp?=
 =?utf-8?B?NE9aVHQyeWNROGdyY0NuZE9BQU1tSFQwcUcxcjFDNXpDUUd4Zy9SdjNNOGdO?=
 =?utf-8?B?YVloVS82bElnVVIvQmxVc1hRYVpnUHBONS9DWWxQalJyRW5KR1FETko5RHFT?=
 =?utf-8?B?MEs3b2svN2IyUFFCQlNEdnFsNnRGeUkwYUxtNUY5SlIxM0cxSndBL2xBR1hK?=
 =?utf-8?B?MmpHQ1pqVnJ6MTJVczFEakxyVnRyY082OFBLcDF0c2k3TVNRV0VvMFZBdFpz?=
 =?utf-8?B?WWtjT1hiSlljakdpY05uMnJvOWtTT1VMQTBwM1I1Y2JkYTVtT1ZtL2tEOUhj?=
 =?utf-8?B?bW0vd3Zad0pWMVNTekcvczY2UHFFRWFQdmRZOXlqek0xUXhudmNCUlFYbUJP?=
 =?utf-8?B?YkhoWnFhQTBpWHJFWVJVcW53QmRqMnIvUjEybTljVU5IdnM0V1huWlc1Kyt0?=
 =?utf-8?B?UkhWNDUvNk9zTEkzWU9IcjlYU1kxZDZPbW1sM3JHZFhRSVpCNUNjQUtJVXJE?=
 =?utf-8?B?TEl0cnZtU05aY09BMGZEMTljeWNhWmFHNVdWRW5RVFF1WkxscEpHUmYxQWVF?=
 =?utf-8?B?OVMvc3MrY1ZPRW1tYldpa2JkUVl4dzVHdDR4dGo2czNlSEk3TDczSnpHQzc4?=
 =?utf-8?B?NFM1UEh0MXAvejZWekRzV3FHU082b25aNWx1MUl2NHM4czdaQnlGcDN1eENr?=
 =?utf-8?B?MzdzbUk2U04zNjRJbFh3b1hUSytMMHpIK3hENzhvSENEbGdLZy9UU0NveFB6?=
 =?utf-8?B?cGt1Sk1KaFVmenlRd29BbGkwY3F1em40WVNVVGdkYUlzTkZZdzdHdzBqeXh2?=
 =?utf-8?B?QUNZaXcvUzRFK1JOUHBQZXY2R3BPcWROa2c2OWNkR2p2V3FJRVFUdTRJM0FM?=
 =?utf-8?B?bis5SkorSjhVYmVodFM1Nk1YN01OSzJLdnZ0MWc0K2twZ29ybGRyZitLZUZa?=
 =?utf-8?Q?BdiF3Fm5Qi/8lIiEB1Ly4CdG2zuptI1smj?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfeecf7-3f40-4751-120e-08d896c7e433
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 13:40:54.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG9VzZl2V3+ucnNdZt9R7tr+G4XWr/d5QG6yWAZQXkVLFeAevtr3PEWaYIy+V0Rz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2340
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On 02/12/2020 00.30, Russ Weight wrote:
> 
> On 12/1/20 12:47 AM, Martin Hundebøll wrote:
>> Hi Russ,
>>
>> On 01/12/2020 00.54, Russ Weight wrote:
>>> Thanks Martin. I'll work on a fix for this.
>> Attached is my in-house fix.
>>
>> // Martin
>>
>>> On 11/26/20 6:02 AM, Martin Hundebøll wrote:
>>>> Hi Russ,
>>>>
>>>> I found another thing while testing this...
>>>>
>>>> On 06/11/2020 02.09, Russ Weight wrote:
>>>>
>>>> <snip>
>>>>
>>>>> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>>>> +                  const char *buf, size_t count)
>>>>> +{
>>>>> +    struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>>>>> +    int ret = count;
>>>>> +
>>>>> +    if (count == 0 || count >= PATH_MAX)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    mutex_lock(&smgr->lock);
>>>>> +    if (smgr->driver_unload || smgr->progress != FPGA_SEC_PROG_IDLE) {
>>>>> +        ret = -EBUSY;
>>>>> +        goto unlock_exit;
>>>>> +    }
>>>>> +
>>>>> +    smgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
>>>> The `count - 1` is meant to remove a trailing newline, but opae-sdk writes the filename without newline, so better do it conditionally...
> After looking at how kstrndup() is used elsewhere, and after
> doing some experimentation, I think the best fix may be to just
> remove the "- 1":
> 
>      smgr->filename = kstrndup(buf, count, GFP_KERNEL);
> 
> The code shouldn't have assumed a "\n", and I don't think the
> kernel should be required to do white-space cleanup.
> 
> Does this fix seem OK to you?

Since we always use opae-sdk to write the filename, we wouldn't even notice.

While your'e at it, kerneldoc in mm/util.c suggests to use kmemdup_nul() 
when the size is known.

// Martin
