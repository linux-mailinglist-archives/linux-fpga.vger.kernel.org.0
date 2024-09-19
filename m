Return-Path: <linux-fpga+bounces-729-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5D97CEE6
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189C91C21DB6
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E505619884A;
	Thu, 19 Sep 2024 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtKxhGUP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A2198838;
	Thu, 19 Sep 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782764; cv=fail; b=A+HHHN/dTGZB/p9qiMHE7D3xAMaQvhjrVDDAoCQW8VvtVEqMR9w/kRuRA+HlY7pDwKThRcTXA+2Gr1JjPR+nWcIRLEvsN5Xq3KL22R1h0ZL9t4oRrhJlNIcMNZqH9AqbrnvmyckLNsXbwLeDGGfk1Y8wBZqV2RMxvmz+oNfnuRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782764; c=relaxed/simple;
	bh=X6cpYFPUCkGjwgPKhCQP7ULIWHG6/7Dt4wKsP3s3wjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hdd5Jkuycs235Qjk2uMbzPtRfyLbyc2yWxuHyzLdoLdu3xPqPdIiStR04NXFSlaH5YEzdQAGqrthQyK1jtJa3vOL6Oo1ytNVzHMwOp7A4JHJ2KhVPbrYEbbD/QIGvb+p6/oMNYeUWs1Ralz1BSpcAUNzIRCRmNWmKrB0+Glwkpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtKxhGUP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726782763; x=1758318763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X6cpYFPUCkGjwgPKhCQP7ULIWHG6/7Dt4wKsP3s3wjc=;
  b=UtKxhGUPbN1n/scQl+Es9WEDnw2Uz6Xu8j2+uj2j3mdqXgsRWIxsTmZI
   1oMRQRAI8bCDu2yDiEibwV60NFLvtQTqcVYNePI4T7/3LZgt4e/dgD155
   2QsR2s7AwQENW6J4VrQ2dp/dSd8jXVGI5Ke6XerIzZX8Gmr88vH6jIMsL
   QUZxH+O6MSnlCi5BYZD5ric5Eef1O3YKAfFqQhzbZ3LNyc83bEyVgSVw8
   MLk6yqbH+8PVpTNk4gmX9OI31o82j3sOQmBjH3wm++F5IQTzcsRAcFa8Q
   nK+XIxCllwpD2ZPv5ulSYy0txWZfmIaCn1QvhaBcEo/bqFlB0axFefqUe
   w==;
X-CSE-ConnectionGUID: fVw4QUfRT0qkzhsOhJXgXA==
X-CSE-MsgGUID: 5wNbz7yBSTSo5T/N3EOjfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29511320"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="29511320"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:52:43 -0700
X-CSE-ConnectionGUID: SHAlwVeDTEClbUZizFseng==
X-CSE-MsgGUID: sTsUNpKNQqWKuNAjlEu0UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70098501"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 14:52:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:52:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:52:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 14:52:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 14:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4REL51R0tqN+9tymCUSQvNCfUjTYye7jk1C1vR6KsrNHN98NvXFadvF5RnInNr8A6Pr6slLSvSzDY91+UH5DluwWpzUfynYy3gZOSxGN9lzWRblqaQNiqAKVJ6QXStGqA3rqs8Qb1Vklafm5cILeOqUVFjWiaP8mUsA4LUPpesKDBtCcqGr7cHS9iT6reRLYEAQuZRQx06F7A9B/VgZsis4xfkRA8zjfKtmRWCLQlJbCnv8XwS7hGf2MJRv6JHvgd8nJrOugcz5hte/yrczlU4t6poUP+tthe7W/UBqlUWyJcDuLZfC1Uub8X6b7pqd7soHE3r3jrMjzvPbZ3BrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6cpYFPUCkGjwgPKhCQP7ULIWHG6/7Dt4wKsP3s3wjc=;
 b=HSLS3EousAuPoDTHP+qeexUtxdr0ZlzvE6bNDIi79035RRkbYyq4Dxf3LtcygqJ4cckiisyM9ZK+Bwzinl8GtfNct2VV1/wUojjGOe8LtIsbcqjWxaLZuPAbbtK7PFNhBxUnZeNI7wuDSFc0MGoEMT4fq3oe1Sn+8hehQwMt9Cq0xvSdjKuY3KZW3/jxcFNQTVAqDP3cCoLGRY06ZOz76NUxWsXp+cUzs6vvdXqLt8fGIfq6D3XEJvjyVMF513Y+BXorkdspl5WwclEsNbe8ZlEcX2Ayap63DhUXdxMd6YEHQOzfD0SSePyDZSRmFonKkhyRwP/kD5u5q412y+wGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 21:52:36 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 21:52:36 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 0/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Thread-Topic: [RFC PATCH v2 0/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Thread-Index: AQHbCt48wPsrDmZYz06bVAizVUoV3A==
Date: Thu, 19 Sep 2024 21:52:35 +0000
Message-ID: <95bff99ee6c5bd37428544c72f5df233c7d602ad.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <ZidxApdiC4cOKYOp@yilunxu-OptiPlex-7050>
In-Reply-To: <ZidxApdiC4cOKYOp@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|MW4PR11MB5892:EE_
x-ms-office365-filtering-correlation-id: cc761648-95c9-4d60-b736-08dcd8f55f73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVJpOWRkdG9MU3FZUWRiMTZadWE1MFh1U0pMSkdwQk9VeG41Z0lBOExVUm94?=
 =?utf-8?B?ZkZqN05SU1JoTE9nYWR3QnZCaVNBZUlqcUUvOHF0a1U1L3hYaDgxdDNpaDFV?=
 =?utf-8?B?YVluSHNDK2FrZUI2S0J3ZUFHbHAwY2JMa2dZTGxBcTUrYkZ1cWVsYWhVTHFQ?=
 =?utf-8?B?Rm9HR2pJb3Y0WklpQW5NOEUzK0RBckVCUitHMkRkRlRoTkpkbk80bC80S3Fu?=
 =?utf-8?B?Q1JqNFl0bzJRMHdkeDZUc2ZhMjFtRkhBV3N5Q0s5eHdUOUR5MGtwVjFzd2JU?=
 =?utf-8?B?ekRjQllIMGdzK3pTKy9BNjdQOGI0bnRnVG1INHp4R1c5YWxMdjF2MWNPUnZR?=
 =?utf-8?B?TVhpamVKU0hRS0J0dUQzOVIwM3pNaGYwK1ZwR09QR0NMNkYzRnZxSEtMa2ls?=
 =?utf-8?B?NkhzY2pSOHgrSStGSVdhWFpVd1RXbW8vTU4yV1JIemtLQndqUER5YWtpb1Bx?=
 =?utf-8?B?NGM1alMvSGFQUGpvN1FIWFNUVHI3Rm51bUx4Nm9NNkswbWNxVmtxVGhublcx?=
 =?utf-8?B?bzA0TnR5ZjdGUHBRcFpZWUVmeTR0ak9Xc2ZlNlJTNHdlckh3Smp5TEtqMjB1?=
 =?utf-8?B?VCsrSCtpZGxLWGRodHFJV3Z2N2V4QXBBbFZwazUvbzlKekVTclRwMzRab09B?=
 =?utf-8?B?R1BjNlJDZThhSmQ4QlV1V0h1Zzh1dy9wTHR1cW44L3JpQm5CaFhONERKNmtD?=
 =?utf-8?B?NTE3RWpZMkkrUzVzUktyc051QnhtMlVWU0ZrbVpqRk14NXFJcUxIc2NlaE5D?=
 =?utf-8?B?ZVEvS2p6M2dSVUNqclJ5MktSMjZreTd6Z3dsSUJPRnVCU0tNSHFDTFlWUGhL?=
 =?utf-8?B?djgwMTc2eGZVOExCNEwxVWU4OU9oYkpGMlU5WExaL1dHdzhmcTlTTWJuS3NP?=
 =?utf-8?B?YlZnT1NoMnFMMkpCbXhXRldlQXFLWEc5c3dsOCt6S0s2YnJiTEpWdXYzSXpn?=
 =?utf-8?B?d1BjNXo3NmRMOHNNVVZlYmJuZXRTcE9JTDZVT1F3dUE0bHc5MGVROFZZVC9D?=
 =?utf-8?B?eENFTWZtQlhPcU9mMmZ6M0FkYlgvZWNhcHlramlsY2tZUE5udFdCZHBNVDJt?=
 =?utf-8?B?a3puNTNlS2Z5a3kyUUFoSzRnM1pvbFNONklYN3ZLeGtVZGpyYlRleE0wZ2sy?=
 =?utf-8?B?VGNsSDY1S29pZVllMHhXQlkyWmZoclc3bmRycjM5bHR0aC9DRUFDeXJTeTND?=
 =?utf-8?B?VURVTk16UDBOS2RoS21acTNySWNncXBDNnIyRWhZVmJDd3c0NFF2dVFobC9N?=
 =?utf-8?B?SUZvYjhKYXU5Ly94bFV0NmxyVEZvRTc3NzQ5OCt0SmdyRWExdmxnN2k2czdZ?=
 =?utf-8?B?bkVXRU1qQVFnK1p3OThwSmtIRURISitUdnFjbTV4a2RNNlovV0dYaW13MUYw?=
 =?utf-8?B?ck82aWtyUy9GUGJDU2dHcnN3dlg5anp2K1Z2VXYxWGhtSy8vSWlvMWlxaTZo?=
 =?utf-8?B?VDJiVjJ3dEUzNjBXbUozazVhT0hwYndpMW4wQnVXWVVDeG9FTGszc0hIWnRH?=
 =?utf-8?B?aEE4MU85RTRwZDArZXVuSkhldTRnQjQvNkJIWEF6N3NTOFZiMnAwTlp2QkpS?=
 =?utf-8?B?aldwYVMxQk04dmFjODJsMlBLeXAxeUtpZ010Uyt0QjhIckRsTVRJdTBmaHVC?=
 =?utf-8?B?VXhLZVJzb0tjS1UvbVR5QlJXSzVhbllsSFRyMTFPREY0dVk2QmZKdmx6QTZQ?=
 =?utf-8?B?MFZFOGVEbVUwcXQrS1JMSlUwd3JoRzRCcVFvUSthQ2pXU1ZrckVlVHRlQTdK?=
 =?utf-8?B?MGFsMllraW94QmNNdkFkNG8ySzlSLzhhQmdLOWl0NytaV2NVcWwyYnVtb25q?=
 =?utf-8?B?dWhXL2ZDSyt1LzRyLzB4RUZ6MmhMRitxY1hlQ1RKMmRmYmovcGEwbmluQlpX?=
 =?utf-8?B?OVp5dnd1M3d0NnVNM3IrMkdhMVJRRkJZSm5ZYWw4UDJGMnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhybEpRbUxydlVnc2JuVDlONWVBSE05UlVIczBtWkdHdmo1TmgzUHVBb0wy?=
 =?utf-8?B?dFVMUnZRT3pEOFkyM1hOczRhL1lsUkpNZEF3VlFjWlRJbWJhcGo3dFF5YXBi?=
 =?utf-8?B?UldSaThVdjN2WlNvWnFyUkl2VjlGL3BIWEJsMDJvdXpYTFYzTnF3QzRES2p1?=
 =?utf-8?B?MEZkNk5JYWNpeDF4Kzh2YXZWNXUyV1hTeitPK29CRkhTeHVmbU84Tml2T085?=
 =?utf-8?B?Vk5lODFwTkZsWkFLbUg4dTlMM1pnVWVRT05NVzUzbHZHSkdDb3B4RGpZa3hw?=
 =?utf-8?B?R0FlcDVSQUp4cEZNR1E4bjJPS1hLVVptT25NZFByMXBSM0laSGJhMUs4ZTRC?=
 =?utf-8?B?YWtXOGVPajZJd292REUvTU5oYmV4b3J2NWdWZklZK2lIekJ3U0ZIRnU5aDdh?=
 =?utf-8?B?S1BkQWJJN0ZXNWs5VU8ydkZZUXRxWHFTcXdxbi8ya0hjaGxKblBVNDlmdEUv?=
 =?utf-8?B?VEhkT0Zid1Nqa3RNeUJjVUhGaTRjT2VkdXBMTm5UajhqaVU5ZzdNb0tNWE50?=
 =?utf-8?B?Z1NHNGQwWUl4cTF3cXdTeEplNkU5ZWV5VXhITXZTVzZYMldybW9hb1VGRkw4?=
 =?utf-8?B?R3BMSi9LTFlsWTNZOExoalVlSFVNeEYvaGZMcDBHYzZjM29KeEo1R28weXg0?=
 =?utf-8?B?MWVBb3Uwa3c2dy96SHlWcERRZU1NM0tRdGFsbG95WnZVazZ0K0VwQ2luMDlr?=
 =?utf-8?B?RHRLTEJDT3hqY3YwNUlkQ2Y5ektQWlpuaGpjK0tncFh1Njg4cjl0eGdta1du?=
 =?utf-8?B?b3ZpM0ExemJNNjc4TFhnNjBlWXpNOXQ0VzBCNEp6L1pBS2pQdHhSMmYzZ0Rr?=
 =?utf-8?B?MGU5Z0ExTnNjdUdaV0QwRUNsWmZtTFM5by96WVJXNUNGL0lNMHNhbVF4aDlH?=
 =?utf-8?B?ZWxQS3ZhVVd5Rk5jR1RDSjhXcUpNSTRwYUZLZG5tWTNuZWdXYUN2YkZHeHdL?=
 =?utf-8?B?emVUdjBNUTNZNDNWZjNxSnZzaVFIclNFMi81MThGTGlQWm1IUW1sY2Nra0po?=
 =?utf-8?B?YmJubldnRWxNVHlCYWNpSlhKTWVpK2M5K0lBcGd5dnJRYllLclIzeTREUlZ0?=
 =?utf-8?B?Tlplb21sekQ1VVVybFdkWjU2amE1eHVydWZNTWVValhsaGNHeHRSeHgxT0F5?=
 =?utf-8?B?Z3p4cVdneU8vSHhmcTg0Q3Rrc1hHdHhFMG43TFVMUDErajQwNXQ3OVVybjl4?=
 =?utf-8?B?djhHOGdzT3RDUWdLL2Q4VjNUOWM5Y3J0RHpNeFJJYXZSYnN0OFQ1cEU1dDA0?=
 =?utf-8?B?ZDZPK0ZSNStMZzF0UlU0SDA3aVBEYkJqaDdydlJlUmdaR2Z3OUVMeXR3Qm55?=
 =?utf-8?B?dnE4b3ZMQzRveCtJU2pyVDlmUnZtQWdMOG95Uk1iSGlqWkFKaXNXUmRtQ09q?=
 =?utf-8?B?amxsUkErTmg4N3Y2SHRKS1htU1J3bTg5YUp5R2xTZ2wxa2RvcDhJNXQ2Q3NQ?=
 =?utf-8?B?aUNKUU15VDVobHpEc3ZaZ0xXWGdKQVNIbUdUYTJKVWttUVFUN0FDOEFKYjdj?=
 =?utf-8?B?Z2xieitZU003dmhObUdVRjJraDZLbjdleUpEUzJTWTZmM3c0SXNUb2RZWGw0?=
 =?utf-8?B?TC80ekR1anNVL1dZeXJkcFhYazNHejB4UjNyRGpyNTNVaTF4RFpsRHZMNFl5?=
 =?utf-8?B?aXc5S0VvK0xsaDAwR0Nva1B2Q3pQdC9WKy9ISjE0ZE1lMHBpODRJcDVCK01r?=
 =?utf-8?B?MDdNc0pPdHowNEMxRkxEb1FHcWdkTDBIL2cxb01nNDVFNHl1OVNFNWxOYXdV?=
 =?utf-8?B?QmhWUzgvV0c5RVE4cmlmM04vN3UzKzBsTlZxU0RmUU9sNjV5OGVwNnZ4U2Vx?=
 =?utf-8?B?YTFDaEdxRzFCOHFpL2Y4QUFCdGx4MUJJLzA2SG1xZzJacUtEam9kSGc1T1R0?=
 =?utf-8?B?ZGErYThCdElYNGU4SzNRQjIzdVVSSEhKcHJsSVRIazZqTVM2ek1wSnFTaTd4?=
 =?utf-8?B?MGVleXNQd0ZNRTZmK2dYUXY0OGFlWmN0bHRJME5mNlJtL2hZbW9raFNIVnRO?=
 =?utf-8?B?WXFQWjlFdDZLSVlUMFN5ZkR2VXBTYXZmMGZMdCtlUWlDNzVzSmpGMk1uNHJI?=
 =?utf-8?B?ZDhtUXRXcEZGVUwzb1h0RFNvWW5PZzV5NnF0bFlSRmFhTHBHaWhsMlNWRmFB?=
 =?utf-8?B?QnBtYlU4QUZ5bTdYS1VIL1ZrVndBMGtnei9PR28vSzBFVEdhdGE0SzMwck5p?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54C99C203A969A4BAADA74C098C68A6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc761648-95c9-4d60-b736-08dcd8f55f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:52:35.9177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0PccGZjp9/2BOGHfdFa3bcs90jZ16L9vNB3zm0y5Ea3TzujwEAMN8HA3gNqlYFPtuBFp39veMwX+gVCTO8UUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDE2OjI3ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDksIDIwMjQgYXQgMDc6Mzk6MzNQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBERkwgcG9ydHMgYXJlIHJlZ2lzdGVyZWQgYXMgcGxhdGZvcm0gZGV2aWNlcyBpbiBQ
RiBtb2RlLiBUaGUgcG9ydCBkZXZpY2UNCj4gPiBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIHRoZSBo
b3N0IHdoZW4gdGhlIHVzZXIgd2FudHMgdG8gY29uZmlndXJlIHRoZQ0KPiA+IHBvcnQgYXMgYSBW
RiBhbmQgcGFzcyB0aHJvdWdoIHRvIGEgdmlydHVhbCBtYWNoaW5lLiBUaGUgRk1FIGRldmljZQ0K
PiA+IGlvY3RscyBERkxfRlBHQV9GTUVfUE9SVF9SRUxFQVNFL0FTU0lHTiBhcmUgZGVzaWduZWQg
Zm9yIHRoaXMgcHVycG9zZS4NCj4gPiANCj4gPiBJbiB0aGUgcHJldmlvdXMgaW1wbGVtZW50YXRp
b24sIHRoZSBwb3J0IHBsYXRmb3JtIGRldmljZSBpcyBub3QgY29tcGxldGVseQ0KPiA+IGRlc3Ry
b3llZCBvbiBwb3J0IHJlbGVhc2U6IGl0IGlzIHJlbW92ZWQgZnJvbSB0aGUgc3lzdGVtIGJ5DQo+
ID4gcGxhdGZvcm1fZGV2aWNlX2RlbCgpLCBidXQgdGhlIHBsYXRmb3JtIGRldmljZSBpbnN0YW5j
ZSBpcyByZXRhaW5lZC4NCj4gPiBXaGVuIHRoZSBwb3J0IGFzc2lnbiBpb2N0bCBpcyBjYWxsZWQs
IHRoZSBwbGF0Zm9ybSBkZXZpY2UgaXMgYWRkZWQgYmFjayBieQ0KPiA+IHBsYXRmb3JtX2Rldmlj
ZV9hZGQoKSwgd2hpY2ggY29uZmxpY3RzIHdpdGggdGhpcyBjb21tZW50IG9mIGRldmljZV9hZGQo
KToNCj4gPiAiRG8gbm90IGNhbGwgdGhpcyByb3V0aW5lIG1vcmUgdGhhbiBvbmNlIGZvciBhbnkg
ZGV2aWNlIHN0cnVjdHVyZSIsIGFuZA0KPiA+IHdpbGwgY2F1c2UgYSBrZXJuZWwgd2FybmluZyBh
dCBydW50aW1lLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gY29tcGxldGVseSB1bnJl
Z2lzdGVyIHRoZSBwb3J0IHBsYXRmb3JtIGRldmljZSBvbg0KPiA+IHJlbGVhc2UgYW5kIHJlZ2lz
dGVycyBhIG5ldyBvbmUgb24gYXNzaWduLiBCdXQgdGhlIG1haW4gd29yayBpcyB0byByZW1vdmUN
Cj4gPiB0aGUgZGVwZW5kZW5jeSBvbiBzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSBm
b3IgbWFueSBpbnRlcm5hbCBERkwNCj4gPiBBUElzLiBUaGlzIHN0cnVjdHVyZSBob2xkcyBtYW55
IERGTCBlbnVtZXJhdGlvbiBpbmZvcyBmb3IgZmVhdHVyZSBkZXZpY2VzLg0KPiA+IE1hbnkgREZM
IEFQSXMgYXJlIGV4cGVjdGVkIHRvIHdvcmsgd2l0aCB0aGVzZSBpbmZvIGV2ZW4gd2hlbiB0aGUg
cG9ydA0KPiA+IHBsYXRmb3JtIGRldmljZSBpcyB1bnJlZ2lzdGVyZWQuIEJ1dCB3aXRoIHRoZSBj
aGFuZ2UgdGhlIHBsYXRmb3JtX2RhdGEgd2lsbA0KPiA+IGJlIGZyZWVkIGluIHRoaXMgY2FzZS4g
U28gdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IHN0cnVjdHVyZQ0KPiA+IGRmbF9mZWF0dXJl
X2Rldl9kYXRhIGZvciB0aGVzZSBBUElzLCB3aGljaCBhY3RzIHNpbWlsYXJseSB0byB0aGUgcHJl
dmlvdXMNCj4gPiBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhLiBUaGUgZGZsX2ZlYXR1cmVfcGxh
dGZvcm1fZGF0YSB0aGVuIG9ubHkgbmVlZHMgYQ0KPiA+IHBvaW50ZXIgdG8gZGZsX2ZlYXR1cmVf
ZGV2X2RhdGEgdG8gbWFrZSB0aGUgZmVhdHVyZSBkZXZpY2UgZHJpdmVyIHdvcmsuDQo+ID4gDQo+
ID4gVGhlIHNpbmdsZSBtb25vbGl0aGljIHYxIHBhdGNoIGlzIHNwbGl0IGludG8gbXVsdGlwbGUs
IHNtYWxsZXIgcGF0Y2hlcw0KPiA+IGF0IHRoZSByZXF1ZXN0IG9mIHRoZSBtYWludGFpbmVyLiBU
aGUgZmlyc3QgcGF0Y2ggYWRkcyB0ZW1wb3JhcnkgbWFjcm9zDQo+ID4gdGhhdCBhbGlhcyBkZmxf
ZmVhdHVyZV9kZXZfZGF0YSAoImZkYXRhIikgdG8gZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YQ0K
PiA+ICgicGRhdGEiKSBhbmQgYXNzb2NpYXRlZCBmdW5jdGlvbnMgZnJvbSB0aGUgImZkYXRhIiB0
byB0aGUgY29ycmVzcG9uZGluZw0KPiA+ICJwZGF0YSIgdmFyaWFudHMuIFN1YnNlcXVlbnQgcGF0
Y2hlcyBzZXBhcmF0ZSBvdXQgbW9zdCBvZiB0aGUgc3ltYm9sDQo+ID4gbmFtZSBjaGFuZ2VzIHJl
cXVpcmVkIGJ5IHRoaXMgcGF0Y2ggc2VyaWVzLCBvbmUgcGF0Y2ggcGVyIGZpbGUuIFRoZSBsYXN0
DQo+IA0KPiBPbmUgcGF0Y2ggcGVyIGZpbGUgaXMgbm90IGEgcmVxdWlyZW1lbnQsIHNpbXBsZSBy
ZXBsYWNlbWVudCBhY3Jvc3MNCj4gbXVsdGlwbGUgZmlsZXMgd29uJ3QgY2F1c2UgdHJvdWJsZSBm
b3IgcmV2aWV3ZXJzLiBUaGUgaW1wb3J0YW50IHRoaW5nIGlzDQo+IHRoYXQgZG9uJ3QgYnVyeSB0
aGUga2V5IGNoYW5nZXMgaW4gdGhlc2Ugc3ltYm9sIHJlcGxhY2VtZW50IHNvIHRoYXQNCj4gcGVv
cGxlIGNhbid0IGdldCB0aGUgcG9pbnQuDQoNClRoYW5rIHlvdSwgaW4gaGluZHNpZ2h0IHRoaXMg
c2hvdWxkIGhhdmUgYmVlbiBvYnZpb3VzLiBUaGUgdjMgcGF0Y2gNCnNlcmllcyBub3cgYnJlYWtz
IHRoZSB2MSBwYXRjaCBpbnRvIGxvZ2ljYWwsIHNlbGYtY29udGFpbmVkIHBhdGNoZXMuDQoNClRo
YW5rcywNClBldGVyDQo=

