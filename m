Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC94E3DB09C
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Jul 2021 03:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhG3BYF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Jul 2021 21:24:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:12648 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhG3BYE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Jul 2021 21:24:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="211124662"
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="211124662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 18:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="417819686"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2021 18:23:59 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 29 Jul 2021 18:23:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 29 Jul 2021 18:23:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 29 Jul 2021 18:23:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 29 Jul 2021 18:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOO0dB/2RKEAC7/N7qY3HynSBdN79CfY83LMwGYx6B4aEQmUnz72Dt9V73Xeox77CObXktsKJFKQ2OX4a57oJmb8cGnzTANXU+J7pzvloSOIcGOc82PYn5M7cvUCeRe+d9sx9JwB6yOOpYdfLpq7QXRl00LY+j25H55HfRrHJdjTZ295oL4cXqSHRQEhPcj9YvREkmryOG2mmIRXKTSMXShZqHKlW6gxECw8BwyaBgzrpeFMgBMAD8lPcY987pXGDxEgQjELokb86satRZbq5zNjEPPpguQkpwGbyIPlWVtMy8k8WhzaFUJnt12iU2Ppbj1I0XqH8zJU51OqoyVcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycIn7MFkBzD1XL9ZesNb9qeAtFzOGjG9gH+jHkMAmhI=;
 b=Ds3pvjI6teOqfT7DnUl7XajbeLEms5w649Sh3D1kin2Q4V4XkKi+0Dy+EXrmGmpR8B3LVKHGaWcCEL0lHc1zENcYUYHeYfhiDQkyFGy1XKc4uVzwWHeKlDH+BqbhH8fu6lcDcNfVZwmQQVgI37BN5nlvFk0CijTLqpcGUBpm8d9OWNM48pB72ArskLiiTmxrJxZ7k0FdWHWFXDbs9260xiGjyzTMHdalBkG9XQDR9HllxodOwl66VfsuK/7D8Q6T4nkk0IEXBGlqydLH5sx581mwzs07jG2Ah3JbqdKTbEZahOgqJnGW9FmDYC1msFnc7zwp6LXC5CgUMRXqohgR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycIn7MFkBzD1XL9ZesNb9qeAtFzOGjG9gH+jHkMAmhI=;
 b=qrZ+/Y1/Ri94r3c4YYI7ssYl4A5s5Wl0gn6/mZsIJo6G4VZTHpnzvRZp/VUk80gQzppPQjBLgfkI2nZ+biBxFWC5ttFwY4QaCjNgyncP6gs8PgpL7NCEpVbTLs49yM1bkFqd65lyDKrkPGij1rRplzcckJuBXg+SJ2lU2S7HARs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3504.namprd11.prod.outlook.com (2603:10b6:805:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 01:23:16 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4373.022; Fri, 30 Jul 2021
 01:23:16 +0000
From:   Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
To:     Greg KH <gregkh@linuxfoundation.org>, Tom Rix <trix@redhat.com>
CC:     Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <moritzf@google.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org> <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
Message-ID: <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
Date:   Thu, 29 Jul 2021 18:23:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:300:ef::21) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MWHPR22CA0011.namprd22.prod.outlook.com (2603:10b6:300:ef::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Fri, 30 Jul 2021 01:23:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 996f2647-33f5-4004-4d1a-08d952f89b9c
X-MS-TrafficTypeDiagnostic: SN6PR11MB3504:
X-Microsoft-Antispam-PRVS: <SN6PR11MB35046B6D4EC15BF1ADE06170C5EC9@SN6PR11MB3504.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uv2GmqwJAWOkSL4lsvY08yIx8eMqIrFV01SG1gNzJgQwxDY7SHEV/a+Wq1x0OITPCycY8y2xa5UK7QJCgoWW4asl+uOJd76wGH8mvGTdyMvIrFnUo3QAfMQR7mpGaIkhdGeclzu6/EemkrT+l7EjixnIf0ZXwgOxz7M3XNIZP24KMi9U57yqNgcMsws79oAuk1fd56JJwd4QXdULZmNA+k4XFjf8exRv204ZHO1oxR3gsB1WA8tLncxZPu4AOR0g/XMd+Ioubn+GRDCw3WcwboJK9FQQT/RiWUwOt+Kxai2wzPe/iMG3xogPcmzzz/0EWHLQgn/hyEW6iAqqL9jB5MBS4RqmgEQaybueLASYWy+CvnH5O/IsKJNJSGB6wWrWI194sSM3rzcY+iPU3hVhjyJSC7XEoW3BbUwqFVQfHdeRbxDYNczx/trv9IujHnpC7OdzKDb/AX6APyEYk0GH5CwDYwTQvP0yfey/1/Jm6l1QHJHpeDhfvap7LVP6YpGkaQLYqov/sWY1e1P+3jry7JtAQ0Ewg/MGcObQLbD9wOiBwZgw+rmOgaKpM7lPH6k256o4aWoVSlqvRy2o3NYMCFMrp9wrm7wKOU9y5/aOgiZl+wQYyIE7K/wrXpuzYpFT7QY9Z3eCSrqAIRKSxfMOiqXkr9yfG1UErX6wTBMm0NPWNjGCfZkIRf5quBsq4+W3aPwg9jlHydFA2NatNydE1j9JaZ77P4ljDaiuKTiKEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(8676002)(6486002)(316002)(8936002)(31686004)(478600001)(16576012)(66556008)(38100700002)(4326008)(66476007)(66946007)(6666004)(110136005)(53546011)(15650500001)(2616005)(956004)(36756003)(2906002)(31696002)(186003)(86362001)(5660300002)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxtU1dHc29UM3dKa3V0SCtRRFQ1dCtiaXFPOWppSDFhelR5WXQ1TXFqY3pF?=
 =?utf-8?B?M2grYWh3dndldHBWZDlNZTAvekJHLzZFK05SejFMM3ZXZVNBNEVOVDFFajdW?=
 =?utf-8?B?Tkc2cXlwZWVSYlUyTWVFUHlidGxQYUZLbG83TzNGenlNelpENnZ4V1ZnaUFD?=
 =?utf-8?B?SjBISVJ6NXFUcVdFcFBHV1dRZ3ZyVE9vV21CbVBiWDJaSnIrdUJxZVF0c2FE?=
 =?utf-8?B?c2g1ci8zeUF3QTRjMGt0Zjc0Zk1FS3BJbUFrVkE2NlRTRHhYczJKUFVxV1hU?=
 =?utf-8?B?N0R5bkJlZGxlbTd4V0dOL0tpWTgyNnpKUkV2SXdMQ29IQ08yc2k0R3dzdVQy?=
 =?utf-8?B?dFFRTUlTMkQvazZhVHkySGVoallNVUtLaGljdWcvNVFPQ3UvVzNpYmxRd2J1?=
 =?utf-8?B?b0IvYlQzNzh6U1oxcndxMnYyZmJtVGVIbzJKWWE0dVdvTnVSdEF5Z0VIS3ZK?=
 =?utf-8?B?OXpQb1RaMElUK0FBWUNKSG5SYTJTWWJBeWlRTGxETTk2UFFpZkc3c0J2aWlt?=
 =?utf-8?B?SzdYcE1YcG1hSy9rQjVDbkNOT3JabEhJQVFhSEkwTlRCdkVWZDBwamdPVEVT?=
 =?utf-8?B?NFhJVEZnSCtUYnlHYVZyYzJBUk5VQXFYZGhMeVFyV2NVS3JuVmpDdDZ2eTky?=
 =?utf-8?B?NzA5UmQra0ptRHRnRStBM1FmSGJHYk1nL1U5K3o4OXYwMksyTG9ZR1hJTmdm?=
 =?utf-8?B?UHZGZXVIRkR6YUhrb3c1UjJpNzhreXNrVTQ3Zk9tYTl6UmRxYWRIYmdoM2lC?=
 =?utf-8?B?YUs5bGVCemJSQ1hBNS8yVGFvRWlKMnpGYllBc2tkVm9YaE16ZCtyYjFDQ2dD?=
 =?utf-8?B?NEFZT3VYQThaT25hZ1BnbTd0YkQvMnV3eVQzZlpkdXhCSnZZTHA5bWxrT2k5?=
 =?utf-8?B?SnU4eWVJc3BCNlhxSEJYb3RIZTE2OVhVcTBkODRwWkp6VXZmTEErWlRoZlhE?=
 =?utf-8?B?a0p1SlA5NzArSFpiVGNXQ3laai9vSjg2amhDTFNWREJYSURFcUJYK1RhTHZQ?=
 =?utf-8?B?S0owQlplNlZMZkJoVkRpU3poYjZIb1lnbnZkRFNoS0xFMGQwVnpmdUVVVEhZ?=
 =?utf-8?B?cmZuR0dlMmFGQWxtNkJXdnhic1Axd1I5SG5WY1BPSjlPdlV4TGtNem9zcFpM?=
 =?utf-8?B?SjE4ekloOTBLMEtmUDlyc1ZnNzJ5ZHkwclgrMXprOFJvTFI3M1hNNjRqa3g1?=
 =?utf-8?B?MkhodjZYTVFNT3RPLzZzRzlTWHBqQnZIT0RJTWFqQzZCeEdMQTlzQTUzOVRV?=
 =?utf-8?B?ZGVuRGRhcmNsZEZkNnc2L2V5di9KOHBlMVhzYkI5UTJtWkxVQUJVM3dCazFt?=
 =?utf-8?B?QXFpZWkyeDhydDY5RGJLbHBKdHcxU2xaTjU3VzNiVUxkTFY1azFLMmlvd29C?=
 =?utf-8?B?YU5ORG9SNTY4TlNGV3B5QjJ4Q05ac0RKYjJDVi9nVmlOY21mOFZldUoyYitr?=
 =?utf-8?B?WVRnK2QyRlB6U3ZNNjBiV2lpUzU1MWJFajhEbkM2N1JvQVQ0TFM1VHB5QmNh?=
 =?utf-8?B?MFlINS9pTXg3cnNQRTh0L0Z6SWdldEVVVEpiYU1YNllyNDByTmZWZU1Wd3Iz?=
 =?utf-8?B?VjJFVFBzZHFEdDZENWpBbjRJRlBIM0psUVFwam5UOUJNZzNNRFV6d1EwM0oy?=
 =?utf-8?B?bmlTSG8rRjl6aHNIczUra3pWTFltWTBtNjlZeHNCRG4wQVYvTFNzbDJSZGdJ?=
 =?utf-8?B?eFhSRjZFWFJHZnBTM0toQjNCT1BYb2VIT0tYQlFYQ0JMYXV0VTBTWXVpYkpS?=
 =?utf-8?Q?vRCrJHgjJVoEED+Sah2+WJjRBUC/t48d4hmYeZL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 996f2647-33f5-4004-4d1a-08d952f89b9c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 01:23:16.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D09uWMtwNr5O5HL/GIRl3F4aTYkQAKD+tMzOKeXUKnqBQTwRn/M5HVC6cEHQ3CJyP0CfVLY3Rr5Buz26DueahogHxNeGZtrKRJOxk3rrr/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3504
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/17/21 12:37 PM, Russ Weight wrote:
> On 5/16/21 10:32 PM, Greg KH wrote:
>> On Sun, May 16, 2021 at 07:31:50PM -0700, Moritz Fischer wrote:
>>> From: Russ Weight <russell.h.weight@intel.com>
>>>
>>> Extend the FPGA Security Manager class driver to
>>> include an update/filename sysfs node that can be used
>>> to initiate a secure update.  The filename of a secure
>>> update file (BMC image, FPGA image, Root Entry Hash image,
>>> or Code Signing Key cancellation image) can be written to
>>> this sysfs entry to cause a secure update to occur.
>> Why is userspace responsible for triggering this?  Passing a "filename"
>> into the kernel and having it do something with it is ripe for major
>> problems, please do not.
>>
> I am using the "request_firmware" framework, which accepts a filename
> and finds the firmware file under /lib/firmware.
>
> Is this not an acceptable use for request_firmware?
>
> - Russ

Hi Greg,

The dev_release fixes that you asked for in the FPGA Manager, Bridge, and
Region code are almost complete. I'm trying to get back to the FPGA
security manager patch set. Your previous comments challenged some basic
assumptions. If it is OK, I would like to get some clarity before I rework
the patches.

Overview: The goal is to pass signed data to the PCIe FPGA Card's BMC. BMC
firmware will authenticate the data and disposition it. In our case, FPGA
image data, root entry hashes, and cancellation keys are authenticated
and then stored in FLASH memory. The patchset contains both a class
driver and a platform driver.

Example Output of Current Driver:

        [root@psera2-dell24 update]# echo -n intel/dcp_2_0_page0_0x2020002000000237_signed.bin > filename
        [root@psera2-dell24 update]# while :; do cat status remaining_size ; sleep 3; done
        preparing
        8094720
        <- snip ->
        writing
        8012800
        <- snip ->
        programming
        0
        <- snip ->
        programming
        0
        <- snip ->
        idle
        0
        ^C
        [root@psera2-dell24 update]# cat error
        [root@psera2-dell24 update]#


Assumptions:

(1) request_firmware(). We had assumed that making use of the existing
request_firmware() would be preferred. This requires providing a filename
under /lib/firmware to the framework. You commented (above): "Passing a
'filename' into the kernel and having it do something with it is ripe for
problems, please do not." Unless you have additional comments on this, I
will plan to NOT use the request_firmware framework.

(2) sysfs interface. We had assumed that a sysfs interface would
be preferred. If I am not passing a filename, then I think my only option
with sysfs is to use a binary attribute and cat the data in. Is that
acceptable, or would it be better to use IOCTLs to pass the data?

(3) Platform Driver. This driver is for the BMC on the FPGA Card.
I think that is similar to the SOC model. This is actually a sub-driver
for the MAX10 BMC driver. Other platform drivers (e.g. hwmon) have already
been accepted as subdrivers for the BMC. Is the platform driver the
right approach? If not, can you please point me in the right direction?

(4) Kernel worker thread: The worst case update is currently about 45
minutes (newer implementations are shorter). We chose to do the data
transfer in a kernel worker thread and then make it possible for
userspace to monitor the progress (currently via sysfs). Any concerns
about doing the transfer in a background thread?

(5) New vs modified driver: Perhaps "FPGA Security Manager" is not
a good name. Simply put, the driver passes signed data from the host
to the Card BMC for authentication and disposition. I looked at
merging the class driver with the FPGA Manager, but:

a) Secure updates make no use of the existing FPGA Manager code (FPGA
state management, etc). The only similarity is in the ops data structure.

b) Because of the kernel worker thread the driver remove functionality
adds complexity that is not helpful to the FPGA Manager.

I can, of course, combine the drivers anyway if you think that is better.

I appreciate any feedback/direction you can give.

Thanks,
- Russ
