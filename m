Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECA4073DE
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 01:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhIJXbW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 19:31:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:51045 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233121AbhIJXbW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 19:31:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="306765082"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="306765082"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 16:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="432452788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2021 16:30:10 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 16:30:10 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 16:30:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 10 Sep 2021 16:30:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 10 Sep 2021 16:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj4ebmYP32IibZS0NRx3oe+/MLkIw5Lb+tIb/LB1y/75DPTfWAt1Irpy4+rE98eqDNqEbamBJTVQt25fxmYuwlq3D8DyJSRB9fpQyE++d9yqA+rRCZKmuyH1PG+c5Nkf+zNRGnqzk7LI9JD1EVKgZAm0ag0cAFoPISbnEfazGZM+o/8XMvrdr1hI3pWadQ74fCGw1/fcbZnswP8EW+K+ITPECeT/OB3TgqLV/4CvRkA88Jtn+KBs2pB/TtOvhOmldUFVKJx215B5l7efewFs0n9QIejl37jwRTKhmVZy/Jl6OWbs/C+jeyMqOIOCqps3D9tPZo1hAtwM68YAr7MAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=txbAZ8P8IwlaUvk4Ms8buhgPHJRugf2yo6AW5+RL9Mk=;
 b=F27eD9gj99osiAfJmSAOsTUiFqUzRWZROyRiy5JPeDP6RMHlrQWEhhzw7gdPNukdBK/ESfRMCzdRTCBvvf5+5YJ1KIShLOeFwulFni3CEeVePY60OOr+EGuE6OTR9h8Ddk2tjNKn4YZCbil6ilLriG2fEPLPGzrAsHaGcQtWEDB57ixE9HA7lQ7MjNlq0bo7IJFYzfGQvRW9oMYuqJMNV6CUNLcQe+zW5r5x6KC3RYuFzqO4GuJKvWcXkQKFX2qyHLvM8zel209Sl7iIbsdSN0xXAfDKt7QQy3aonWvpeSe9fzARqbuIYMKPuLeaUcUUCMaiR3QXeATtOpKP1XUvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txbAZ8P8IwlaUvk4Ms8buhgPHJRugf2yo6AW5+RL9Mk=;
 b=ftonOOYN9FFDU8X3XK8iIUS/cMfM9CXSQQtICOXBGqrrKn7quuJTeSSPywDyuaOVOAqVZz/jcsy5aPlw4CTWtme5LuhVKnxdvW9KygAec70KdMdFUtObMhwzaJi0O75rPaimdzWnBn2g2VMPwemE4f1Py0qQdXsrxoDoAebjT48=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3262.namprd11.prod.outlook.com (2603:10b6:805:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 23:30:05 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 23:30:05 +0000
Subject: Re: [PATCH v15 5/6] fpga: image-load: create status sysfs node
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-6-russell.h.weight@intel.com>
 <20210910085238.GD754505@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <bc14ba58-a457-68dc-ca59-720adaa32524@intel.com>
Date:   Fri, 10 Sep 2021 16:30:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210910085238.GD754505@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MW4PR03CA0026.namprd03.prod.outlook.com (2603:10b6:303:8f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 23:30:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 177cb214-0000-44d1-7ef5-08d974b2eb80
X-MS-TrafficTypeDiagnostic: SN6PR11MB3262:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB3262DFC4E279CFAA5F229AADC5D69@SN6PR11MB3262.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fm32JQDf33msHRvwCub3LYxGjxMXlG2QMUjtULuyfUvcJLJo6wWwIytXx0qDpsBGXNf9wb4EeUyBbJKGyBpOVQxLqrbrys7tz7VU8wlZyy27NQ5BQeS2GR6/HEuppnllzua6o22fsj6+51fJ5bqWDmy4VPwEalRVZG/HXD8QxMfkK7egaybdHTBTvbgQg96lZ2DnT4RL7R0Rmb9l/NaAmR/KEU+9EFFCXhxqG1tYDhcLmbpR/IADZsuX4fa8xpYzQ4hEjdAxSGOhQVf0P2pDpF7uW93H0q6MbT0v9iS07xGztNFzkMXjmHxsjDw8MKBLc/l/GAdkyY5RWwGIWVYRagwnN49C3vVRMN2Z39BrabWU5AGWm+QalFpZ4ECC2tXEyWmoe7s4pJ5GVbwD1Jx/WbipyED/r6lnFwAK901VX+KsUnGjFgdqiC7NoQuQAkUCEERFaxKRBUfLSZvdAIGk2IaWylWDQ8lJTzbQ6bMjaLgAMN9WdCY+wmkVCxEjJ4JPrPTPmLDVVjAPEJsfo1d31pJQ4IiPZl1bZjLJ+VBCTjAC2fY53oMhGpn+mpXkbIJexaA83KrfnNdrugpbBjQPBZyJx3bA36rNAeoGhFP9xm75bQkqIgpP0WXFApg5Ow3L7gfWbSeQSEz4NfePu73q4WvA+0Ns6jf2F2F7Z5nRPDr0Ey6xWq0+iUpCz42wsAlgjTd+dXTt23BuVbwt8/Gd/UKMhhauoYd4PPYACbSMC60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(4326008)(26005)(2616005)(66476007)(66556008)(66946007)(53546011)(186003)(6636002)(37006003)(83380400001)(86362001)(5660300002)(478600001)(8936002)(36756003)(31686004)(2906002)(16576012)(31696002)(107886003)(6862004)(8676002)(956004)(38100700002)(316002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1M2K3E3ZkdhVytWbVNOTXBhZ1VvY0lSWVh6OUFrdkdNd0ZtNktzMG1TY3Nm?=
 =?utf-8?B?MlBNdm9SVlgrREwxaHQzeUwrWkhqTFB2TFdTLy9sQWplU29aR3MwdndTRU1K?=
 =?utf-8?B?anlRUjVsUmNObzIrY3g3by9KeW9hakpaSldPYTFVbUNlNU11N05na3hPZ3FD?=
 =?utf-8?B?RngzVk5OWUIzRVcxQlkxL1JEeVFrWmpVdFF6T2pXSUVJcFRMUGRWOEZHc2NM?=
 =?utf-8?B?L3l5MzdraHVYQUdCcjBoMjdxaHFlc0JIR3BiaEl4WW41MTcvU2VmYXB3QlVN?=
 =?utf-8?B?aXFYR1UrYUZnNmZuOGVUYXY4YVFsMExHdFZWWGFDd3ROSGRJdzhFS1lpMEw3?=
 =?utf-8?B?ZHBvZjRuV2VDQ3pUT2Jxc1RkNFlZTTU2YWN3aGRkNW44a1FISGxnYjdiMGlI?=
 =?utf-8?B?YngxYmVNUHBwZVozUVIzbkJYLzRXcEF2ZjhUb0pKUnVYS01mcjFEQjNYek1i?=
 =?utf-8?B?dHBkdG0zd3VrOXRsQkVsaTRLNXZrMFJFQ2NsM251MFVlTDkyVDB5MXllc296?=
 =?utf-8?B?MDFCbmliTGR1UHYybDExZEJ5TFNnS1JiUHVDV0RFV0UycXZvNGszeEtWMFM4?=
 =?utf-8?B?QVJmVzhibGM4TUhpelRTK1ZDU0FJT3lsejQrTStEMkE2dFBjdmc4dGY0TUhO?=
 =?utf-8?B?RXpkNlZRbUlmT0taU09Od2k5VU10TTE3N2Rub05HWDQySWQ4cWRGaFdIOFFa?=
 =?utf-8?B?QVAvNm5CdklzblpjNVFXVTlEMGxnbVJTNkZQQVJDNlVVYTkzYXp3SFN3U3p2?=
 =?utf-8?B?QkNxZ2F6ejJPd3Vjc1NmempYczgwK2JvWkgrQlJiT3FweE96QXBQZzFWTTNC?=
 =?utf-8?B?dHhkM3hFL1dDRTl2c2lPdXBKM3dQbHlrbkFrTENJN3BPN3FOS3g4QTMwY0FQ?=
 =?utf-8?B?NkRtTWNCMWJxK3FtTDBmQjVPWlRJY01kSWw5SkdSWjFMOFRJSXR2OUNUVVls?=
 =?utf-8?B?YXd5dlBoZU1WaWJYZjZ1ZUlENW5zVVBaMEcyeUJwUVdPYUZ4VEdXcTZiMEZa?=
 =?utf-8?B?SUQ5cW0vUWdHT2lLVXRFbUlKbEdVVlRmREozeE80YVY0aTFMa1N4VXFYMjBj?=
 =?utf-8?B?R3pQMHQ4aHZrdUFiWnRsazlmaVV3KzlIVmt3V0c1WE9zcm5kT1NheS9aSEM1?=
 =?utf-8?B?eXB0eDVPamJwTm1hQ0dJd0NoSlpBR1kxdnpDQ3pYOUdiK1g2d2VDTW9FMTZQ?=
 =?utf-8?B?UDBiZ3lHa1RMY3UwcGszem11OUp1YWVNaEJiaVF5NDhOR3VPdmtVWXl0akJC?=
 =?utf-8?B?VXFDYkliYmp2N0dPVjlGc0ZKdWF5c20yM1FManpCTkI5eVJwNXMxMHB5Y2dG?=
 =?utf-8?B?V05Ta0xnbHZTWUdUMHgwUCtWUk5wZStMeVVvZWpXQ1NNM3ZtL1gwcHY2bG9s?=
 =?utf-8?B?QmVkRTV0RWdEZExGMzZ6Uis2OUsyVHZMWVZGUFNVOVFzeG5rUy9lMTd6aEZY?=
 =?utf-8?B?bDdXOG1PMTVzNEJVdVBta2Zaa1hGaGRGMy9XcS9PWW10VXhzVDF2N3FSQnJG?=
 =?utf-8?B?SGRGVHhJRjkvWlVQVmRGZzk1Y0lMVm8wcnloMWtuRHRtSjhub2NDRHhWWDE1?=
 =?utf-8?B?OVlPbHpmZlpoMDVGWmVuMXZudisvU3BIU0NpZzFLT095WU50bHB1bFhLNThQ?=
 =?utf-8?B?Y3I3MnBTQW9jRng1K0NiWnBiR2RwMWF1K25xaENOMTdUdWhEaXV0U2Vsa1NH?=
 =?utf-8?B?dUE5RWxrcFRrbndYbC9YNHRPNEdiR1dvdWs3NWVvY3BhWE1BOXNGbzdFd1Bw?=
 =?utf-8?Q?Xy1Jd/ooqLEuidoIuR4NwbkSIsK6caS9xLjS44m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 177cb214-0000-44d1-7ef5-08d974b2eb80
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 23:30:05.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCjjitSMq73NxlEkx8tYn6aMu0r+k9ouhCrp8ex190Jety84RXO1QaHNfzlg9RpcfRPjxUW7LybI4F6lhqJCDQ3epBY0LdWSUo6Z1pxvC/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3262
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/10/21 1:52 AM, Xu Yilun wrote:
> On Wed, Sep 08, 2021 at 07:18:45PM -0700, Russ Weight wrote:
>> Extend the FPGA Image Load class driver to include a status sysfs node that
>> can be viewed to determine from the command line if an image load is in
>> progress. Status will be one of: idle, starting, preparing, writing, or
>> programming.
> The FPGA_IMAGE_LOAD_STATUS ioctl already provides the progress info.
> Why we need 2 user interfaces for the same information?

Updates on Vista Creek can take up to 40 minutes. I thought it might
be helpful to have a simple way, from the command line, to verify
whether or not there is an image upload in progress. Do you agree? Or
do you think this is unnecessary? Should I remove it? Or save it for
a later patch (after the main patches have been accepted)?

- Russ

>
> Thanks,
> Yilun
>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v15:
>>  - Compare to previous patch:
>>      [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>>  - Changed file, symbol, and config names to reflect the new driver name
>>  - Removed signed-off/reviewed-by tags
>> v14:
>>  - Updated ABI documentation date and kernel version
>> v13:
>>   - No change
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>>   - Changed syntax of sec_mgr_prog_str[] array definition from:
>> 	"idle",			/* FPGA_SEC_PROG_IDLE */
>>     to:
>> 	[FPGA_SEC_PROG_IDLE]	    = "idle",
>> v11:
>>   - No change
>> v10:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v9:
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - No change
>> v7:
>>   - Changed Date in documentation file to December 2020
>> v6:
>>   - No change
>> v5:
>>   - Use new function sysfs_emit() in the status_show() function
>> v4:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>     and removed unnecessary references to "Intel".
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>> v3:
>>   - Use a local variable to read progress once in status_show()
>>   - Use dev_err to report invalid progress status
>> v2:
>>   - Bumped documentation date and version
>>   - Changed progress state "read_file" to "reading"
>> ---
>>  .../ABI/testing/sysfs-class-fpga-image-load   |  7 ++++
>>  MAINTAINERS                                   |  1 +
>>  drivers/fpga/fpga-image-load.c                | 33 +++++++++++++++++++
>>  3 files changed, 41 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-image-load
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-image-load b/Documentation/ABI/testing/sysfs-class-fpga-image-load
>> new file mode 100644
>> index 000000000000..6c04a49f01cc
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-fpga-image-load
>> @@ -0,0 +1,7 @@
>> +What: 		/sys/class/fpga_image_load/fpga_imageX/status
>> +Date:		Aug 2021
>> +KernelVersion:	5.15
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read-only. Returns a string describing the current status
>> +		of an FPGA image upload. The string will be one of the
>> +		following: idle, starting, preparing, writing, programming.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 637bc003ca81..e3fbc1bde9bc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7362,6 +7362,7 @@ FPGA SECURITY MANAGER DRIVERS
>>  M:	Russ Weight <russell.h.weight@intel.com>
>>  L:	linux-fpga@vger.kernel.org
>>  S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-class-fpga-image-load
>>  F:	Documentation/fpga/fpga-image-load.rst
>>  F:	drivers/fpga/fpga-image-load.c
>>  F:	include/linux/fpga/fpga-image-load.h
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> index 99a47b21c995..6ec0a39f07b3 100644
>> --- a/drivers/fpga/fpga-image-load.c
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -236,6 +236,38 @@ static const struct file_operations fpga_image_load_fops = {
>>  	.unlocked_ioctl = fpga_image_load_ioctl,
>>  };
>>  
>> +static const char * const image_load_prog_str[] = {
>> +	[FPGA_IMAGE_PROG_IDLE]	      = "idle",
>> +	[FPGA_IMAGE_PROG_STARTING]    = "starting",
>> +	[FPGA_IMAGE_PROG_PREPARING]   = "preparing",
>> +	[FPGA_IMAGE_PROG_WRITING]     = "writing",
>> +	[FPGA_IMAGE_PROG_PROGRAMMING] = "programming"
>> +};
>> +
>> +static ssize_t
>> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct fpga_image_load *imgld = to_image_load(dev);
>> +	const char *status = "unknown-status";
>> +	enum fpga_image_prog progress;
>> +
>> +	progress = imgld->progress;
>> +	if (progress < FPGA_IMAGE_PROG_MAX)
>> +		status = image_load_prog_str[progress];
>> +	else
>> +		dev_err(dev, "Invalid status during secure update: %d\n",
>> +			progress);
>> +
>> +	return sysfs_emit(buf, "%s\n", status);
>> +}
>> +static DEVICE_ATTR_RO(status);
>> +
>> +static struct attribute *fpga_image_load_attrs[] = {
>> +	&dev_attr_status.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(fpga_image_load);
>> +
>>  /**
>>   * fpga_image_load_register - create and register an FPGA Image Load Device
>>   *
>> @@ -373,6 +405,7 @@ static int __init fpga_image_load_class_init(void)
>>  	if (ret)
>>  		goto exit_destroy_class;
>>  
>> +	fpga_image_load_class->dev_groups = fpga_image_load_groups;
>>  	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
>>  
>>  	return 0;
>> -- 
>> 2.25.1

