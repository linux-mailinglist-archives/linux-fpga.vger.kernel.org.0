Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF673D6946
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 00:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhGZVck (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Jul 2021 17:32:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:21553 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhGZVck (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 26 Jul 2021 17:32:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199553956"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="199553956"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 15:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="579901393"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2021 15:13:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 15:13:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 26 Jul 2021 15:13:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 26 Jul 2021 15:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPxVXc5jI/FLYCiiByA6PFSyoNnjg3EEPxkOTVFslvRA7qglFjIpQibqqDKAmi+l4MUqdjBpYEfyIdZpAmi9Fn+Vp0BcSjPii3gyH5phaPEMVkYaX2OqIG1FEIRizV2GKehghW0QTUf36z4KN0GuIQFbde6cZ87+O9Li0qhm4aTINL1b1/LSpEzk6eq+Vcd0sSBuH7oRtyul+bLatQhof6gVINFGIn/GgubZ+3qDUmR+HS+TrK+HGvsJXKNiQvxirvYnEw8doWrZH0hjhJ4F3y5eA5ZA88WdESXW1UhY2/si8STUuwjH7DDrFv+rZ2cJf+SwyKVhIkOyQslPL3uHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddmg74I+XlEo0rWDssk8104gW4HLLINvpqKbhsCke7M=;
 b=bHz1a7EnP4qH5KL7+wTCVccHbsjR6cF6E37jHWIaGvISaqPd3me5Q4DdK1P86yXNPw8Nwy9YKJYUQXM6Z7wkbYbrkWrNMVUAExZhop9KXP9eqihUbt2z93zc6ro/maXjdXuT25ZS5OIWO3ze1zouQl9nOX8/L6n5gxjW82gPSrgN7KOGlnNI2tPs3vYptgtf8BOF3zq7pHMCd7L8hchNfUuDOt19rPlH2dznd/GOHsbbXR8YdpkRxi9TKfOdBQJAymD2thqPhLgxH5thTZxQk4H7X0ZkRrBDGKIxzghDY5jBK7VUG3oI4ChNvVtAznN8Dhko1YXl+JC3JYI6NH6pZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddmg74I+XlEo0rWDssk8104gW4HLLINvpqKbhsCke7M=;
 b=XfukPAgMOjYRi6fQxVPT+h8NjDGJ8M+p0525m/2PbTHNjz/KYnBZrvZlXXaCK9DLDKmxRmMSe7SqMt4k1RqyBmSS66o9BHfg4FvlsgWHzNlzXLnuPG+Zgb7kH4QanqC1ifJ1TDwVRLKexCP2QS83cW6UCz+Lalw7n3yGN36Wn+8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 22:12:43 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::51db:698d:e2e3:7fc8%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 22:12:42 +0000
Subject: Re: [PATCH] fpga: region: handle compat_id as an uuid
To:     <trix@redhat.com>, <hao.wu@intel.com>, <mdf@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20210726202650.4074614-1-trix@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
Date:   Mon, 26 Jul 2021 15:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <20210726202650.4074614-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.4] (50.43.42.212) by MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 22:12:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72155bb8-d792-455a-db10-08d950827d4c
X-MS-TrafficTypeDiagnostic: SA2PR11MB4889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB488936FC66A9604EFC8F2EEBC5E89@SA2PR11MB4889.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhoU5KQfzrTJrqNQkdIXExE25PNnd7iML98zRqAIiRhLNasXzsjvcpAcSbQb42LXtVd4Qu/26+0VV3PwrqmzDOWl+1ZvARnec+Vh3UFSm2hY07zLn6zvA2IW4M/A71K/WKmVU+ckOuR/BGFyvSeYhyfpwzHhmy4WucvD/sEPs8tKlFudGyaR8gDd/jeLf6fz1/ImqHXFdWzb62tdX5n53cqni6rRcWUGfMIvItEKv2yZbvbZyIOIrRWWJKt+Tq/bvgWvPj6gZNgqKh7ulYFsXl1cfKWSuOH+UdkXetzUCNhl8B3fe7AHjCyZTJQ9PEufCZtAJckhs887IF8B64O7wlTi7j0FteLG3YaVjr53AMC6ehW7/ZPGZtqo85bA1PW/bAg3wgqa75MtBLDyYa4N0XFq1SbAl2Gwe+9/bH1fOJD/Y0BkpVN9MkTkDRW0ltLoGVEVraepVQ9noNcm1JEr5ClBmJuL96hF+9xpxIh6S2vzr2aPhcqxxT0ug0WX4KPc1oLs5Q1s7FCEC0MNJq8FCe/qTGv0tL4A6n+SOF/g5tCgYm3fVnDZSNCropuBW5z0fF0OzPBFpWU146CDLE2jIntI7kUkEFXb5i+XO9Tqp7qhpDIKxwzlMdoFzZsaTdkIEOzBnOxX20aU6L2vPkLq+AlNIkgzEaRIDNWvN4Fctzdq/wmLqKN499Rl/hYdi827nhvs/JfX0UBgDkVHH/oD5OoYcoTpwiW7Zm3PnXRetD/iGN79sC6NHA2l8O311Y/p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(36756003)(66946007)(31686004)(2906002)(8676002)(4326008)(31696002)(8936002)(2616005)(316002)(956004)(5660300002)(186003)(6486002)(66556008)(66476007)(16576012)(478600001)(83380400001)(38100700002)(86362001)(53546011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkdHenFlOGRybVRhN1ZaZm1qRThYVmdha2t1K05lSlZsWUFzbjZySGR1aFN2?=
 =?utf-8?B?SGNEYkw5R2FwTEhxNVlvRFVwWks0NEJpUEgybUZMenNHcmFJWEpXNTNyNkZM?=
 =?utf-8?B?QVhhLzFreUMxVWtCay9YdVBEb01NaUVVNDR1bk9xcDdTbk1GRWY3RUhwSTQ4?=
 =?utf-8?B?azRQeFkralRTV0taYTlsVlRhTG9tUFF6QjVNRlpqZ1VvTDNHN2ZVamREb3Ru?=
 =?utf-8?B?cDM3a05CeHkwRHZUOSsyaGhSdkxZcVZudlZYQmtRV0VGZlRKNUVTclN2ZGNm?=
 =?utf-8?B?cE1RcEllc01walZDcWs1T2hwdmRTeGhmbGlmMHdEOE9FazFENW5zWjhxN2lQ?=
 =?utf-8?B?UnNwMVVoTHcxVjhObnVZWEorVndXOFBIdEd1ZUxkdklxb2FqWFJaUm5VT3dC?=
 =?utf-8?B?N3pvRC9kVWw2WXlyUkZwNXJ2VEVIeE5aa1lMWXJXTXhEeGZoWDgzRlFEeGF4?=
 =?utf-8?B?VGZwWGxhc2dSdHREY1JLSncrQllSM1I4VmRaV0VEOW14L09LV1JVRFlXaVNo?=
 =?utf-8?B?bk01Ui9jMkRWTVhwRlpNVGhzWnVMNjJ6ZHp2eXd1RWRlUDZiSmlKdnRnV2FZ?=
 =?utf-8?B?VjZHS2FaK3A0RUdWOXpjU1k3dHNXR2RzT3lZUk5za3o4VUFBUXdrUlJ0UmFG?=
 =?utf-8?B?Zmg0VHhzYmx1ejR0Q2hpWk9ZSVBqd3lMeXdBdkJtVkgxTit0RCtnZDF1YTlu?=
 =?utf-8?B?NTZQa3BMdUt6eWI5cnZ0MDA2TFBqbVNjR3c0Q1A4aE9jR0MvVHJoRWQ5ZlFO?=
 =?utf-8?B?WmdxaGlvdGRhZ0JCOE9NRWFKRmtxUDAyeUlidTVPaWVkUGV4dDlmM0tIR3gv?=
 =?utf-8?B?MjZqKzNRdmRQaWZQbkVWMG0rS0RrVHdBcW9hNU5xR1duYWEvZFQvRkJLYjln?=
 =?utf-8?B?cGxVUFd5NFlKY25aRGsrbVZ5eDBMUGNENS80UENabHFtdmhOR0FRSVZyaUtx?=
 =?utf-8?B?MjNtcnFOdDQ3a2JFNnM2SlFOenZvVTZ3RTJUeWVtQUtpMHk3SE9XYmx0eFNM?=
 =?utf-8?B?VGNrdmR1T1VEczc2SXVFaHZ4eko3U1RZRjJvdDFRdVIydjhRTHpxa0hOV0RP?=
 =?utf-8?B?MGxvdk53WkRnam9NZ1U3TkJ2eGc0SGMrakI5L3dQR1UzaXFxUXNRYnZOclFM?=
 =?utf-8?B?cXp2SUNqU1ZEaVRUdjJTZGExODlraU4xTHNpRFczOCtiNjhFZ0lxSlVUY1pV?=
 =?utf-8?B?ZkFrcXVVTXNTbEdWL052OWxzZ3lFamxKeGtMa2FtT0xObGZUNzJUd0tsV0I4?=
 =?utf-8?B?OHlJS3RWVmxUQXpLc1JrMHpZOXRmbHhjd3NHUDdPbDN6Z1N3SDdVS2gxTXla?=
 =?utf-8?B?clNBQUcrWTIrNnZsTm5uQk8xTlIzRFVZakx0ZCs5LzF1NXVWZUpReERzeU5C?=
 =?utf-8?B?bnB6bTZDcUZ3WnFwcjJseFhkd0l2RDUvU0RWZ1hXT3M3SVVnOVloTDRReTBD?=
 =?utf-8?B?d0w3L3p2aktmeFpuUlFmZGRKT1c3ZkFZaldjV05hOVM2MXFGTmx5VW9YOXRN?=
 =?utf-8?B?bU1pWU9oZzRiZ01mbTBzOXViV09zb0xER056Q1pkOW9XdER6ZU55NEVwL0VF?=
 =?utf-8?B?VjQrZ0JPMk9wU0hNaFdjOVlGN2I3aXhZR0pZTTNXdVZ5MTJiOTQzQzd2blBR?=
 =?utf-8?B?TGRTMmRNTUM1WHBLeXhzSGdKdUhPWXZDM1NxanZONVJ3SndiSWtHZ3RjRnhl?=
 =?utf-8?B?QzkwRjY4S0M5YmZtazgxQ20vTk54QUQ4WGJldk1LMzBoRXdRNENrTzY3RVR6?=
 =?utf-8?Q?cxsP0SYgRUXhBcT58qF7TCF+iICAbKjelaQ4nYF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72155bb8-d792-455a-db10-08d950827d4c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 22:12:42.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28M2cQqsLeNyOLAai1NRn8gJ6iOf6KGoApltPnK6uxDqYrsEMFFH27bJKMx1TgHSdA7a0P7Gs+2zj7E9bnOywtvI/JTGzatpr+59MbWJRh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 7/26/21 1:26 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>
> An fpga region's compat_id is exported by the sysfs
> as a 128 bit hex string formed by concatenating two
> 64 bit values together.
>
> The only user of compat_id is dfl.  Its user library
> opae converts this value into a uuid.
>
> ex/
> $ cat /sys/class/fpga_region/region1/compat_id
> f3c9941350814aadbced07eb84a6d0bb
>
> Is reported as
> $ fpgainfo bmc
> ...
> Pr Interface Id                  : f3c99413-5081-4aad-bced-07eb84a6d0bb
>
> Storing a uuid as 2 64 bit values is vendor specific.
> And concatenating them together is vendor specific.
>
> It is better to store and print out as a vendor neutral uuid.
>
> Change fpga_compat_id from a struct to a union.
> Keep the old 64 bit values for dfl.
> Sysfs output is now
> f3c99413-5081-4aad-bced-07eb84a6d0bb

I'm fowarding feedback from Tim Whisonant, one of the OPAE userspace
developers:

I think that this change to the sysfs for the compat_id node will
end up breaking the SDK, which does not expect the '-' characters to
be included when parsing the sysfs value. Currently, it is parsed as
a raw hex string without regard to any '-' characters. This goes for
any "guid" currently exported by sysfs and for what we read in the
device MMIO space.

- Russ

>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  .../ABI/testing/sysfs-class-fpga-region        |  4 ++--
>  drivers/fpga/dfl-fme-mgr.c                     |  8 ++++----
>  drivers/fpga/fpga-region.c                     |  4 +---
>  include/linux/fpga/fpga-mgr.h                  | 18 ++++++++++++------
>  include/linux/fpga/fpga-region.h               |  2 +-
>  5 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
> index bc7ec644acc9a..241359fb74a55 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-region
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-region
> @@ -5,5 +5,5 @@ Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	FPGA region id for compatibility check, e.g. compatibility
>  		of the FPGA reconfiguration hardware and image. This value
>  		is defined or calculated by the layer that is creating the
> -		FPGA region. This interface returns the compat_id value or
> -		just error code -ENOENT in case compat_id is not used.
> +		FPGA region. This interface returns a uuid value or just
> +		error code -ENOENT in case compat_id is not used.
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index d5861d13b3069..012b72712684c 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -273,16 +273,16 @@ static const struct fpga_manager_ops fme_mgr_ops = {
>  };
>  
>  static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> -				  struct fpga_compat_id *id)
> +				  union fpga_compat_id *id)
>  {
> -	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
> -	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
> +	id->id_l = cpu_to_be64(readq(fme_pr + FME_PR_INTFC_ID_L));
> +	id->id_h = cpu_to_be64(readq(fme_pr + FME_PR_INTFC_ID_H));
>  }
>  
>  static int fme_mgr_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
> -	struct fpga_compat_id *compat_id;
> +	union fpga_compat_id *compat_id;
>  	struct device *dev = &pdev->dev;
>  	struct fme_mgr_priv *priv;
>  	struct fpga_manager *mgr;
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index a4838715221ff..f1083b5894635 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -166,9 +166,7 @@ static ssize_t compat_id_show(struct device *dev,
>  	if (!region->compat_id)
>  		return -ENOENT;
>  
> -	return sprintf(buf, "%016llx%016llx\n",
> -		       (unsigned long long)region->compat_id->id_h,
> -		       (unsigned long long)region->compat_id->id_l);
> +	return sprintf(buf, "%pU\n", &region->compat_id->uuid);
>  }
>  
>  static DEVICE_ATTR_RO(compat_id);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index ec2cd8bfceb00..b12f9994932e1 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/uuid.h>
>  
>  struct fpga_manager;
>  struct sg_table;
> @@ -144,14 +145,19 @@ struct fpga_manager_ops {
>  #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
>  
>  /**
> - * struct fpga_compat_id - id for compatibility check
> - *
> + * union fpga_compat_id - id for compatibility check
> + * Can be accessed as either:
> + * @uuid: the base uuid_t type
> + * or
>   * @id_h: high 64bit of the compat_id
>   * @id_l: low 64bit of the compat_id
>   */
> -struct fpga_compat_id {
> -	u64 id_h;
> -	u64 id_l;
> +union fpga_compat_id {
> +	uuid_t uuid;
> +	struct {
> +		u64 id_h;
> +		u64 id_l;
> +	};
>  };
>  
>  /**
> @@ -169,7 +175,7 @@ struct fpga_manager {
>  	struct device dev;
>  	struct mutex ref_mutex;
>  	enum fpga_mgr_states state;
> -	struct fpga_compat_id *compat_id;
> +	union fpga_compat_id *compat_id;
>  	const struct fpga_manager_ops *mops;
>  	void *priv;
>  };
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 27cb706275dba..7cc2ee543efb4 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -24,7 +24,7 @@ struct fpga_region {
>  	struct list_head bridge_list;
>  	struct fpga_manager *mgr;
>  	struct fpga_image_info *info;
> -	struct fpga_compat_id *compat_id;
> +	union fpga_compat_id *compat_id;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
>  };

