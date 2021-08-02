Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884083DDF32
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhHBScJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 14:32:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:54501 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHBScI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 14:32:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235442357"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="235442357"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="440674134"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2021 11:31:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 2 Aug 2021 11:31:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 2 Aug 2021 11:31:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 2 Aug 2021 11:31:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 2 Aug 2021 11:31:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIQ26PaoqmLA0NtniiHBjYFQUPly7rIzJA/KDHGDG1LWWLFh2WjwWEr6f3BLVW9w+p7uWvpR9Fcok+qNstLXvxcief1+6+uQmuzXIo17AZi2gicP0+scaJQTAQ6KjNY+lQmuOxpmAhm0iG54ogQTnE9ZKQ2rpU1RMW5YTlyqe0sROscnaeuM4Hy0hrvcPuH+rXyP9iQpuksygAjdlivO/Bs7h9hRXwRW1jVIygvGeJHF+SBlSYVOOCLdWYyWibRvgfIJcDF0kgn7T54AnQ/t7h/bgkVNFk1yoyBNzQWwmoNmZ7TOnWnArmFlMoktPjzkFtvhuhz55cDMHqEzls51nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd+7hO0dAxLmvFQoT4jEzRwodWAaWdWHgr5lkvcv3rI=;
 b=bE0FTrXCcUsBwUwIlMJCcL5W55XM6R1o3vPfoU1DQSn4ZCF/miSY2BpIlPJgcgjSiy+OjlDJ4wSdy8vjQGkmCOU3NzyCW4COAOAal/qWYbQKya8fGiSuuFCXzXtJxmvldkB2kMksoE56JVn5bQNh+9bmJPVSJLKId38RJ+1VB88DJOZgg2QuwjjYb2X9qeyR8aoCFurJuOJA6BKZnM9R9bxpG9wyEoegT4gFWPdVPNpPhic6l3FazoSdokflyF4Vhhikf/GHwK6JoIaI4IqOQfY2wNOdOvX22nxfCgwgK81oXsAlYXr8uU8jveAZiVoQdIWxr9QbDPoE7HynfNvXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd+7hO0dAxLmvFQoT4jEzRwodWAaWdWHgr5lkvcv3rI=;
 b=iE1TsHMZ7HXnuWMD1M5CWZUkQtadjqdVdTEACDkDsbY3Qe7gx1Bsr1pLWqPvwurpsbIF/ZZdaVBlp9hHo3p+z73rF72zAyDIc3XozbREVimC12Rptlaios61XiBVyK55ZR/ANafSu4Y4SAZal6rCKoHQYiPeRVpXgU+P4UDEVbk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA0PR11MB4592.namprd11.prod.outlook.com (2603:10b6:806:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 18:31:56 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 18:31:56 +0000
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <moritzf@google.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org> <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com> <YQPgFn/z024U06HJ@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com>
Date:   Mon, 2 Aug 2021 11:31:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <YQPgFn/z024U06HJ@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 18:31:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55cfacc7-f711-4c6c-ba22-08d955e3ce65
X-MS-TrafficTypeDiagnostic: SA0PR11MB4592:
X-Microsoft-Antispam-PRVS: <SA0PR11MB4592A0B8E04E291EA4565BB2C5EF9@SA0PR11MB4592.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szxAGbfrGYN1HF1Akc2kWg4IV2v3BFUTCyO/EzrDuOKclYvoOk+mWTbAliZK9bKReCGLlAJbpAQcbTMGwq3B9VLHh8EvkPMmbxWUMjGORerLwk1HRGZPbA41bXWPNGLAWsIOy1fysPD8kJ/TQzM3T5svBqru43B8SawAgTuNxU1l3KRwYWi5z+U3JlPylQnT8I+HY+2vBwH0qfa9rjMXy+aWMAyHXKCaQ3rVViOyAtSMSpCi43McH1qwsflXkBBYpmt6UixrMQpWQWL9INiervyUB9Mnu5seYAzya6Tmd2FCtzA+KZ37baAjmwd5ca1AVNmGQIXcBAqsQMn2iqCJ32dNobZY8g2nnIhnCjlOYuMG71rq0aPlCXyyAVVxfBwu/LRrhKWx87iohHwNy17XmjyxOcK0dK+dMLBSRQVUbtev6yUhuhj7IGJMtOvvz1hDh0BKCrSPgABKDsVzMgl5ZckX9CWAggN8af77uQCEkZjnqdUsrWIkktT9+6KcHn3StGL54M3UMwQteuFeKVfoMcqLT4xsH4oboy5WpAaggcEYfpAvxRS0wyBC4qWugx7KC1TIwf9ejhhqmw54pNBLMvwCvDWE1RlNy3nTVGiHo0XXEvNyiQT1nmE0BpC0JjuDcr1JiInzdqXwfroxxGLVAZMCPUXsm5UoK6L99TSCUSpoSn+/7dZDBiHVZvyFfujDS2ZVuCVpZrlHan2ksjV+8pmZack7eAj24oOkK8XPq8yGNZzrV1iTnbZxXoTvvWfUHPahtkjzPfkSWjx9Odf818SYIGDWxHNiYbiTmeX6uLrtC7oG4GF8wRj5xlYGjwE9lmSjxmNwgE1Iqp5o+PKeBqb581B1igqT5v156tapaYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(8676002)(8936002)(26005)(15650500001)(186003)(6916009)(53546011)(31696002)(6486002)(54906003)(31686004)(2616005)(956004)(83380400001)(16576012)(86362001)(66946007)(6666004)(36756003)(2906002)(508600001)(66556008)(966005)(66476007)(316002)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFJZaTJvZlhvRHZiemVZVXcxMUpNZ0Z1UzdwajY3WWRvRUhGYTFuT1o3aTg1?=
 =?utf-8?B?U1NscHRIMytiRE5oOFZjMTBZTmNZbTh5WldsQ2lHOUhpUVVWMXVTdHdjeEN3?=
 =?utf-8?B?bW56V1h2NGJ3cDV6M2s4K1VyaWl1Q3ZLM2gxK2tHV0w3bFIwcWZmS2plYk5Q?=
 =?utf-8?B?NldScmJ2MU1ZcENlUTVaanJQbUpHZm5LWHdkbE8zZWNscFFQSG5iN3A0cm5s?=
 =?utf-8?B?VmtRbDBHUmV0eS9WYmptdVRGY3Vsc1NKbE1UMFZ6Nml2SkJxWnhkYnMzZ0lS?=
 =?utf-8?B?YmNUYkEvTE0ybzl6SzI2LzNINTNhMlpBYmZFVlBVSHJNRlhoYWRoMTZEMlhP?=
 =?utf-8?B?enFETVloRUhwQkU3eXZMZjJFSGFkS1dHM2xCNXc4bG9yLzZxTlUyaVRPM05O?=
 =?utf-8?B?ZjNjcW85eFpZVVQweHFMTVAzQWJvdWs4SjAxYXdpNGhLR0xjUTJVRktVcG9H?=
 =?utf-8?B?eHZnN3ZBUFpiZmJaNWxzZnBibXEvUlBPRll0dGM5RW9Mc1ZycFBpQ1hxaURr?=
 =?utf-8?B?ODI3OXI2Ym1DWDZwckxBQjd1NUE5RzI5RzZvbmdmK0tJZGJDV0ZMVGNtdWkr?=
 =?utf-8?B?aHVvWW1URHNiZmdTZElnT0dUYnhTQWpDNUhBQ2pzbjIrbmJvZk9VM1RLcjg0?=
 =?utf-8?B?MlpKTGpQYWxIa2dIU1VLMUVoYlRUVFNkdGh5cjhMTlR6TGwzZkY0UWF4L0Nt?=
 =?utf-8?B?WXR6ZC92dUc1Q2s4U0VHSDVRSi80Q28zVXoxajhYMVlqUEI5TWF2WEd3Lzg3?=
 =?utf-8?B?OFY3Z29ITGYxQjRJMDdGYlQ1QWplUnBCQUtjMnQ3UWJWRTRab0pwbzhLbnNQ?=
 =?utf-8?B?MEU0NmRaV2FPL2srRE56dlRxdU14Z2hXNTRLT2NLUThtRTJZQ2ZXZDhCNFlX?=
 =?utf-8?B?NEliWDlkNE1aTk9RNHJmN2h2RHRFdlBwMnZobTZtRE1TMkVGMkUzaXE3ZTVI?=
 =?utf-8?B?ajNpY080WmRLdmZXbElBQnh2SVdPSHdWL2JsREhqM3Q3Si9JMEZzSFFHTkVx?=
 =?utf-8?B?OTZwczJzOU8zLzVKNGZzR2NPQnpxdVpZN200U0taTDhabWdESEhQblozK09K?=
 =?utf-8?B?TVcxcUZJNnI1MlhqWi80OVVZQ0Q5STJiVVVRQmQ2dlViRzQxVDhIdDIrRExy?=
 =?utf-8?B?VnBsWkdOdWVXMjE0UmcrTFl3STV2NjlENXJBTTZtRThwUTdhNFhYTnpmeGlL?=
 =?utf-8?B?WlpJOW5vNDZXS1lZN0VpVnZuTXdORnRqcjh3NldWYVJWdDhhbksvYnduN1dm?=
 =?utf-8?B?Z1Nsek9EaWJHUTFtMGRYUnp3djZxdklScHJXZDU3bXhhVkVYNFpzeEN4Vy9i?=
 =?utf-8?B?NHNlOEJhTnBwQ1FzSUFXUnd1SVJVYXExUlhHangyaEhkemtVbDVNdzNxdGtn?=
 =?utf-8?B?eDV2bmpCUzRYWVZIWXl5S1VSYnRZTWdEc3VjNDhCYjRiZzMxdElaZ0RDWUpi?=
 =?utf-8?B?NGZqd0xlTUxUVzV2VDAyVmlwaUFIWGtZNmk4azdBVmc1M3BQWFlNektoWnN0?=
 =?utf-8?B?TFpVaXczSVFkVzBBd2RZWDIyTXdTYlBreXlRQVlXWS9lTDh2V3Q5QVNRdmNU?=
 =?utf-8?B?MkxVdlE3UEkxZk03RGpQamNjM0dzRmJpOFFLS3FKSUkzRzhzT2E3ZGJJVEsw?=
 =?utf-8?B?NXZTUVdNZ2Q2NWF6a2J5Skp6eXdlWWgvcFRNaDE0S05jVGRMM3pHVzdFVGtL?=
 =?utf-8?B?NWp1Y1AwdUpJbTR3OUZLMlg5SmZVeWQ1eGNHdUp3Qkw3OTlEOTVSUzM3Vm5q?=
 =?utf-8?Q?s3NA84s62xZBiLGt89scP4DEvWyObOsN4S4+DXg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cfacc7-f711-4c6c-ba22-08d955e3ce65
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 18:31:56.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XvXccrLBM6B6Zsttg7HqQMHLKTyKn7a1mEoR9qtKHnoSU1C9fOCYJ95L7zTEYmhWsP2uxYvJX3r180tNaEFi4Jp94Rj0CRGmM5khAEy9xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4592
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 7/30/21 4:18 AM, Greg KH wrote:
> On Thu, Jul 29, 2021 at 06:23:12PM -0700, Russ Weight wrote:
>>
>> On 5/17/21 12:37 PM, Russ Weight wrote:
>>> On 5/16/21 10:32 PM, Greg KH wrote:
>>>> On Sun, May 16, 2021 at 07:31:50PM -0700, Moritz Fischer wrote:
>>>>> From: Russ Weight <russell.h.weight@intel.com>
>>>>>
>>>>> Extend the FPGA Security Manager class driver to
>>>>> include an update/filename sysfs node that can be used
>>>>> to initiate a secure update.  The filename of a secure
>>>>> update file (BMC image, FPGA image, Root Entry Hash image,
>>>>> or Code Signing Key cancellation image) can be written to
>>>>> this sysfs entry to cause a secure update to occur.
>>>> Why is userspace responsible for triggering this?  Passing a "filename"
>>>> into the kernel and having it do something with it is ripe for major
>>>> problems, please do not.
>>>>
>>> I am using the "request_firmware" framework, which accepts a filename
>>> and finds the firmware file under /lib/firmware.
>>>
>>> Is this not an acceptable use for request_firmware?
>>>
>>> - Russ
>> Hi Greg,
>>
>> The dev_release fixes that you asked for in the FPGA Manager, Bridge, and
>> Region code are almost complete. I'm trying to get back to the FPGA
>> security manager patch set. Your previous comments challenged some basic
>> assumptions. If it is OK, I would like to get some clarity before I rework
>> the patches.
> Note, I do not have the time, nor the inclination, to help your company
> out with design reviews at this point in time.  If you have questions
> about this, please discuss it with the open source managers at Intel,
> they know the current situation quite well.
>
> I am glad to review patches that have gone through the proper internal
> Intel patch review process and then sent out to the community.

For what it is worth, these patches _were_ reviewed internally before
they were submitted to the public list. The first public submission
(Sep 2020) included review tags. I was asked to remove them and let
them be added back during the public review:

https://marc.info/?l=linux-fpga&m=159926670526828&w=2

Unfortunately, Intel review tags were not volunteered during the
public review, and it didn't occur to me to solicit the tags before
the patches were forwarded on to you by Moritz.

Most notably, Yilun and Hao contributed to the review both internally
and publicly. They are both listed in the MAINTAINERS file:

Xu Yilun <yilun.xu@intel.com>
Wu Hao <hao.wu@intel.com>

All issues/comments were resolved before the patches were sent to you.

> That being said, I will make one comment on your questions below:
>
>> (1) request_firmware(). We had assumed that making use of the existing
>> request_firmware() would be preferred. This requires providing a filename
>> under /lib/firmware to the framework. You commented (above): "Passing a
>> 'filename' into the kernel and having it do something with it is ripe for
>> problems, please do not." Unless you have additional comments on this, I
>> will plan to NOT use the request_firmware framework.
> request_firmware() should always be used for requesting firmware for a
> device.  Having an api where you write a random filename to a sysfs file
> and have that loaded by the kernel seems ripe for disaster though, I can
> not think of any other in-kernel user of the firmware api that does
> this.  Or are there examples that I have just missed?

I found an instance of a driver that allows the firmware filename
(under /lib/firmware) to be changed via sysfs:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-mic#n107
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-mic#n117

I get why it seems dangerous to provide a /lib/firmware filename via
sysfs and have the system automatically transfer that data to a device.
I'm just trying to figure out if there is a preferred/less-dangerous
way to do what we are trying to do.

Our objective is to allow the user to provide a new, signed FPGA image
that can be loaded on the fly (think cloud environment). The PCIe FPGA
card authenticates the image data with encryption keys; the host-side
software is not trusted by the device. So, other than checking the data
size, host software just passes the data through.

I think our usage is firmware-like, but it doesn't exactly fit the
current usage of request_firmware(). The firmware filename isn't
hardwired into the driver and the image isn't loaded at probe time.

If the request_firmware() implementation is not acceptable, then would
you agree that an IOCTL implementation is our best option?

- Russ

>
> thanks,
>
> greg k-h

