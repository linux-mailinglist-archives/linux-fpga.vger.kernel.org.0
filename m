Return-Path: <linux-fpga+bounces-946-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D09D30FC
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 00:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D744B2129D
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27981D2239;
	Tue, 19 Nov 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjsNsjz/"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A401BD9F3;
	Tue, 19 Nov 2024 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059478; cv=fail; b=S2SWTZeydRszcLXsIN3tenVMVKWQ27l9KRdygR6SG8rr0oXx/lAFjgcMa8O5eMRFdHQgHEPF1dqcM5eGCt64j+RbbXIrKw3eshEcJTrYSM06pl1HnpqXQ7pJTcaw732xIccFvL+gBo4G2HvVbtHFYbpbLiE2eoo2pUWA6uYJZkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059478; c=relaxed/simple;
	bh=9epeIVyLzfOYT0FLekV6+GOddyWISsOfxDSY9Km+3XQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulyjkkFimSjJn9Z9g2WK/pMxfoH/pcz7jBtIZsdz1I9vAO3+tVmjEWwxZU89WLVSLtYCatJRHNVKoT/jailBurRmwv9P5Oz4IYC2KfkvZ2psOvxtvHX9iLXmK8aI9aS84BspyzEdH1EgCf8kVrkJSVMtBQ4WCETefpEnMkt6rRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjsNsjz/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732059477; x=1763595477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9epeIVyLzfOYT0FLekV6+GOddyWISsOfxDSY9Km+3XQ=;
  b=hjsNsjz/fI9xos893FcPkf751ZtiJ/BKzhHnxKa0z1NZ0BLLk7gDRqm/
   EyjdGNoCMJzgP42E0RIHDM2mv6Q0FKUJtJM0yN+udrTt2BNj0RIt794CD
   RCpn/0fgjFRbAN1aoIa+s2Tlbwn9cUNXJf+F9guKqLm6EDaoMigjfu4+A
   Miu0RwmJqggsQMpmXi4CGAqYuGYPWcfnnc3wyu3gq17LX9ROX2b8Hn6pV
   3FoI+4OvqBkOfYQxwv95cVhIoKh+cswKVIcVf+r0lTmU0yLcv52jqbN79
   N8RMIQDB2RbTcYco7S0i/HtM+zhAJg0VOs7Krh4sbk7nb0haKZe6hiq7Z
   A==;
X-CSE-ConnectionGUID: 1zOc6c4LQMyPMTIqiJnhmA==
X-CSE-MsgGUID: XOwvKU0ATfKgRBzXsOUOQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="49522568"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="49522568"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 15:37:56 -0800
X-CSE-ConnectionGUID: PpmsX0STS6SBZ/GWjUX/+w==
X-CSE-MsgGUID: ISh+klZ+St+dvGIk2zEzXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="94796626"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 15:37:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 15:37:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 15:37:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:37:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWvseHyiaHOV3ZwfQBBf3msXEDlvb2J/oMxSjjieNbxk0grsNkOlbjd4Q+qBGfn+Q46I2VO8cEn6+xdnX/wybfgjkAkJP5pr42pbfTmaYEVNNbWJIo5dml5cqy97GZjFxG2XL8vJvklNdZMirz8W7Ghyz6jR8w8qbiinM/p34p2YvTZi9QIOklrPI2SzACqTrFm4/h8QM/5ml5K7C+TrE9Ul9rLUxKWN3m3pVnWWt9tZnbVU+yOdMyHmzxeKMeEMu0MI0RC3Kv66qTKOdQgb0SgzfneyXrRgr4UJ4KJYfh5J+zLgmVGPHzCfJ1AtpQ1WC8G9A8Hr+YpiItKW5z5Tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9epeIVyLzfOYT0FLekV6+GOddyWISsOfxDSY9Km+3XQ=;
 b=RcKEn0lnLFkE/RXJFjFsU5HVtX2hLw3Axnr/G/lTEJhgKDo7pX3Ie8hWolspFK0WWBxIX9u6IP3y0ZJ4Qf+p4LUqXycO18GQWYI/UDeVNLDj40iXexexO4UkAXC9Q+XjHksk6kIgaTCq4KOodlAQii6ED20Vu0jH4D+KXHHGtteVOk0RiwZq4E+mRgNGHHloZBWu1WXDB+qMfYLq1mTbotTupwvksC9LImt8MBsmzu8UvEsD1SNK9+GgVCWyjS18RmOMI2SIlJ9SI9HgA/sRAL74TRUSqmyEiCiPeFsOcDJu9LUt/QDdYTixxyz6JJBS58TVxvKINQZ9lnSIrffmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 23:37:52 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 23:37:52 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"basheer.ahmed.muddebihal@linux.intel.com"
	<basheer.ahmed.muddebihal@linux.intel.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v4 15/19] fpga: dfl: convert is_feature_dev_detected() to
 use FIU type
Thread-Topic: [PATCH v4 15/19] fpga: dfl: convert is_feature_dev_detected() to
 use FIU type
Thread-Index: AQHbOccl64/8e9xONU654dYn5+TbPLK9p8EAgAAmxQCAAXYCAA==
Date: Tue, 19 Nov 2024 23:37:52 +0000
Message-ID: <c2809c33594fb280a05c2c24fe2e87439a92d6f2.camel@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
	 <20241025223714.394533-16-peter.colberg@intel.com>
	 <ZztQAsDCyRqGm6UW@yilunxu-OptiPlex-7050>
	 <bad311610de9738e88982fabc46c04b15cdc3650.camel@intel.com>
	 <ZzvnkPzZ7FBPgonr@yilunxu-OptiPlex-7050>
In-Reply-To: <ZzvnkPzZ7FBPgonr@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|PH7PR11MB7605:EE_
x-ms-office365-filtering-correlation-id: d1913291-5f47-4fef-ec06-08dd08f32f98
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2pla05EZjgzaHpUajNidDhiYnhGWE9pNFVldUxBanRRUFhyNVBTOTJIbERS?=
 =?utf-8?B?K0JlU25WelJxL29IVlR3bjV5OWk2QVJUMHJ5NWdHNzRHLzJBL0ZnR05zdCtG?=
 =?utf-8?B?QmdsN3JpK1lsTHRrdFY0dFQwdGxkZTRSTU5oUkZDb2VBS1dsQWE5RWM0SUht?=
 =?utf-8?B?VURRUThGUEovQnpKcWM0d3B0RVN5eVY5eWFsMTNRcFhPQkY0eFpPRmM4QVVw?=
 =?utf-8?B?V0VTUnhoRHNDbWl2RkpISTJaN2dFbEFtU2plTWhIbFRoUFNDZzhyU2pqVnhv?=
 =?utf-8?B?T1RFMktiS1I2bDE4VWp6QkUrVkhMVG9XNlpMQTlCbkhIM3c5bHYySXhwcnQw?=
 =?utf-8?B?MUtacDA0Nmd1dnNaUTNFcGFjNFl0K3pBekVGQVFkTFoweHJaL0pSL2JQNlg1?=
 =?utf-8?B?NW1Kd1ZFVjBYcDFWQ2JzdUtkcFUyOVBVd2tzcXcreFRlT3RXNTVYMW1rUkJw?=
 =?utf-8?B?Z0xzQ0l0MjZnODlkL1ovUnQ2U2RXY01BeGtMcWRSVnMxSGtDL2VHR3NDNU51?=
 =?utf-8?B?eGtnT0xLQ3dTNzNqVnlrUVA0bGZsd2x1djJFRkZneVgvdW1nWGZTMHNTRTlk?=
 =?utf-8?B?Yko2ZWFIQUcyNVUrUkIyS2htZnRRN3hNQ3RzT0w4VnF2US82RCsrZWN3SW1W?=
 =?utf-8?B?TVJwc1hTaEgxQjAwcFNRSUxMN01KZnI2NzNDV0pCZGJVbkxDdTYyaHpFbWtB?=
 =?utf-8?B?VDQrVzFzR3hIK1UyLzQxd1NCNk1QanBRTFJvRzVjc1NCeEFrSjBuSGtYcnBm?=
 =?utf-8?B?YVljVU5kZUFCa3dlM1pUcWF1UlJyeG5vYjZEN0t2NFBWa2NuVlFSQkxaNDVz?=
 =?utf-8?B?RHFKOTkrM3YvL2NFMnVRdy9JODVySmtXQzM2MmxNdUZJbTJsVStyWk5MZFlr?=
 =?utf-8?B?QkdlclVheFRjQmxnYi93TkxsaTFFYnFSUm1MdmM1Q2NhSU1tT2JLZ09Wc1pD?=
 =?utf-8?B?OUFDWElmUjBvaHpsbUVSN0V5Q2hMR3lMTmNINmtBNzI1MHI2YTZoSm9BVXg5?=
 =?utf-8?B?SnR3Vm82b0M5TnIydUdkaUoyU1NLUi9QRzJOWm5XZzVjN0p6ci9oaFlyempP?=
 =?utf-8?B?RHVmdmpsbktkQUFicDdzYkdHRUVnZzlVbytKTUlBUzZueHdrT05zd2RQMUNS?=
 =?utf-8?B?aVIxc3FpNmRhRVIrbEhmTUJ1M2hRTkxxWkpGV1h5Z3RMb1VEZE1RQStaR1BX?=
 =?utf-8?B?bmpvVDZzWHkvM09uNGkvbG5xaW5SbGhKdHRuazlhcGM0UURvZ3J4YloxUFFj?=
 =?utf-8?B?MUZ5M2VQMjVNd3ZrTGxwcVlpWmYyZmZUTm4rV0gxVklYZnh6UEhRYnJIWDZC?=
 =?utf-8?B?WDBMUkhCSWZvSmdvdFBFZzl1QUtseEl5WTR4NUs5d3BiQWdCczRHTW8zSWVO?=
 =?utf-8?B?RytOT1U4eHc5aTZMVFN4eTlLd2VzMFY0MFJPTlorSDlqMEdvTCtrbU03UWdl?=
 =?utf-8?B?WGt4YUU1YmZrbU9MdVZzVHRkekRWenBHZGxUTVl5b1lWUUhrVy9TQStIM2pX?=
 =?utf-8?B?SFBDZVUxYU42YXk1SUQ4TnVJSXhmNjJJVmVVdndlV2FRalliR1B6NFZxTm41?=
 =?utf-8?B?VUZ2OElMK3drU3NwanROZTBLSGZQb3ptOUQ1UHlFNCtHZXVLbnZ5UkwyZHp1?=
 =?utf-8?B?VjhHZnFZUjFsd3RRcTROcVh1ZUZydzZUNXFqTHk1ZVRFMXAveHMweVlOZ3Vn?=
 =?utf-8?B?NnhUME1jbkVTdjVLa2lRMkdtU3Rpc3ltQkFibGF2OUYyWCtsTnhDMnRUQkxp?=
 =?utf-8?B?Y0F6bTcwVDhCZG52a1pjZzd6ZHdvRjhxV1BnWTZ2Vi9xZFJ0cE9OUmRNTE9k?=
 =?utf-8?Q?kEEBQoMvD0oIe4zfBTSQQv4JbE+hkXPFTeXAc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0tqUnNZNW5vcGk5UzE5NDREVVJLS3BROE9abkJ5VllnUHErem8yM21nMGZQ?=
 =?utf-8?B?cko0citheHNBMW55UDA1Mzg0dzRPMnpmOFlWZ0JIQUZSU0xQaklSYWhhSnVT?=
 =?utf-8?B?bzV2MHV0VFByN0xyNkVOZWNHMlRBWDhKNytPTDFQL2wxQloyem5tQlpWaUY1?=
 =?utf-8?B?cW1Za096R1dtQTRzcWd4eG9OaENNTnJuUTFGa040b3dGM05sazdVanI5V3lO?=
 =?utf-8?B?Z3AvTC8rQjZQdERCWHlGZEt4eHM5L1ZmWEdrd3IrVWE1RnNPOGJiS3hncDF3?=
 =?utf-8?B?ang3R1FYK09mem93UzJrd0UvaEU3ZS9zcFlWcmhkanl1M0hoUFg3blpiVmNa?=
 =?utf-8?B?NTVYVVl2TEppcHkwSm5aQ2YxVm14blJ2SGoxNkhWM1FZdjg5T1o2aFRSdkVr?=
 =?utf-8?B?dVBsdm1pRVFJRG5WRDNkb2RSOFBvczdBMkNQSHdJUTMzanVEVndSanVPSlk2?=
 =?utf-8?B?WU1lbGlXUmJ6eHhrQ0N3czYxSHBibHgyOG1UVnNtU0VlQ0J4RWtBZmh3WVl3?=
 =?utf-8?B?QXRySTRqUG1aMzM3M2FXZG9DVHdtemYxUHdhcFdzeENScUVYVmQwUDNoVHV4?=
 =?utf-8?B?empJSlREM3ZDRjB0VTByTG0wZVRnS0c5QzgydkZoVWdnUmN6TkVPeVBjODRD?=
 =?utf-8?B?ajJ0a3F5dm5pbXlRd2JpNHVnQ2JhUW9EcHNtZXFDNk9PV205SFlRSVVkdXEv?=
 =?utf-8?B?MGxuaEIzRmhKc1RJK1VjK0pmRVZkaytRcGN2dzJrVEhsZHpTdmJvbytzeWlV?=
 =?utf-8?B?QTRMRWM1TG5kUVVZRUY4NVJyUDNqUmFNL1NSM1IwazlvVEVBd3VIYjRBWXo2?=
 =?utf-8?B?ZnZNWVV6cTlxeTZnRi9tVDY1bXg0TTkxNmpZKzZZMEZqQ2xkV0g1TFJpandB?=
 =?utf-8?B?dE96SEFDeXNZcGlEK21yVGVMdEF5QllleFp2NDBxTVUycEpOQXhCY2ZWNkFG?=
 =?utf-8?B?VFlxTGhrakJuVjVHUzNKSjBZZWRnZEZyaDVFUWo5eUJFaXZURW5JaU91Yndo?=
 =?utf-8?B?emNCM2d3ZW1JT0szR0haOFNwcFY3NWVxcFF4UC9IR3BlZW9rT1lDQ0M3ZlZo?=
 =?utf-8?B?WVJWQzdTWW5IVGZ1a2tkanlCQmZhMUVhd284alVQRmQ1RUtzV2h1RmVXTXBI?=
 =?utf-8?B?dDlYMCtUdkZaVDQxM0ZCK3pFa0FkY0R6aVBjL2Myc21ORFAwVmh5MUU5WU9q?=
 =?utf-8?B?eGFHbkFuQmNPbEdNTG5VZ21qME5aVFVIbmc0bFpoYTlENElSMnV3UDZjM0M5?=
 =?utf-8?B?SDhMWEpxUGdSYjFxaXVHSnE3QXUzR1AzbklhSndLUGREWnhrSHp6THlkMkZs?=
 =?utf-8?B?NitENWFkUktSbHBjamxuVWVXZTM0ZU5PUDR3aTlWQmdHa1hhYUlaS2NlUllP?=
 =?utf-8?B?YnM1Y09nWS9jbCtvOWREcEY3M1NDOTl4TklFb1M3bmJ3R3JRT3RTVHh0S3RK?=
 =?utf-8?B?M2taSFlYVVVSR2M5TDhlOUFuekY0RFZualpyQ2JDR0FqWVFQM2dNRkZ4OWhJ?=
 =?utf-8?B?bUVRZlRHcXZjOGdDSG5TZDFTY2lVK0IzNnZURTRCRHg4R3BnbENDMkZBdzhV?=
 =?utf-8?B?NUxWckowcVhPNFBaVFRKdnpFUUx6Q2R1aVUvQW5oYTBRQzVubnAwT1pLUkl0?=
 =?utf-8?B?cnUwSGE0QU44Z3NTTVl6d3A3elVPdTNiTFNQY0xZOWwxem1Za1gyb05mTEp5?=
 =?utf-8?B?bU1LSVA0U09FaEdzMDlyLzc2bjRpYlpRUVVFZ1VrQUR0NitVQ0NuQ0hGZ1hE?=
 =?utf-8?B?ckNMNUlYQTlHWnB6a0RIVEdMZ3J1QWQxek56OTl2ajlRNUdpUURhUnpudmFq?=
 =?utf-8?B?c1o2OWJoVGxKSG1rYlNjaFBnNHpYSlNIZ28zalpMRU83dzZTUldKdFdmTWJP?=
 =?utf-8?B?d0JIcm5TS21CbGpRcGhUSVhsR1ZkWGl4Zmt3aFNLTktwc1A0eDYxM1BCZTd6?=
 =?utf-8?B?TU8zTXYyV00yTTZlWUNBTStEMi8yMlIrak1OT1RQbTZrcG01S0dxd1cxY3hO?=
 =?utf-8?B?a0REa09SZWxaYTNsRlNkSFRPNE1tamVvUXRpSmlsTTlyZzNpd3c5Z0JNNGI5?=
 =?utf-8?B?amxBaHk5UWZrK2ZMSm9FbkFzWWpvcW5sandqbVBqRUNYUXZZMksySGpXejBr?=
 =?utf-8?B?RlFBTk5pNzg4dG8xMUt1NkVMRTZMMUIxMlJRTkRocDBrM1BnZFRGV1BNbThD?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1FF57961321594DA4764A67E9EB9FAF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1913291-5f47-4fef-ec06-08dd08f32f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 23:37:52.5075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPBgGUBkvbwSogNsznVJpmZSjOe6c/qF/PYaE4D9yaxJa6uZjwzcSJWIuNGLfCUD9jJoE+lMKwY8p12DY4tuzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTExLTE5IGF0IDA5OjE5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
TW9uLCBOb3YgMTgsIDIwMjQgYXQgMTE6MDA6MjhQTSArMDAwMCwgQ29sYmVyZywgUGV0ZXIgd3Jv
dGU6DQo+ID4gT24gTW9uLCAyMDI0LTExLTE4IGF0IDIyOjMyICswODAwLCBYdSBZaWx1biB3cm90
ZToNCj4gPiA+IE9uIEZyaSwgT2N0IDI1LCAyMDI0IGF0IDA2OjM3OjEwUE0gLTA0MDAsIFBldGVy
IENvbGJlcmcgd3JvdGU6DQo+ID4gPiA+IFVzZSBiaW5mby0+dHlwZSBpbnN0ZWFkIG9mIGJpbmZv
LT5mZWF0dXJlX2RldiB0byBkZWNpZGUgd2hldGhlciBhDQo+ID4gPiA+IGZlYXR1cmUgZGV2aWNl
IHdhcyBkZXRlY3RlZCBkdXJpbmcgZmVhdHVyZSBwYXJzaW5nLiBBIHN1YnNlcXVlbnQNCj4gPiA+
ID4gY29tbWl0IHdpbGwgZGVsYXkgdGhlIGFsbG9jYXRpb24gb2YgdGhlIGZlYXR1cmUgcGxhdGZv
cm0gZGV2aWNlDQo+ID4gPiA+IHRvIGZlYXR1cmVfZGV2X3JlZ2lzdGVyKCkgYW5kIHJlbW92ZSBi
aW5mby0+ZmVhdHVyZV9kZXYuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGNvbW1pdCBkb2VzIG5v
dCBpbnRyb2R1Y2UgYW55IGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50ZWwuY29tPg0KPiA+
ID4gPiBSZXZpZXdlZC1ieTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXgu
aW50ZWwuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogQmFzaGVlciBBaG1lZCBNdWRkZWJpaGFs
IDxiYXNoZWVyLmFobWVkLm11ZGRlYmloYWxAbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4gPiA+ID4gLSBOZXcgcGF0Y2ggZXh0cmFjdGVk
IGZyb20gbGFzdCBwYXRjaCBvZiB2MyBzZXJpZXMuDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJp
dmVycy9mcGdhL2RmbC5jIHwgMiArLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9mcGdhL2RmbC5jIGIvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gPiA+IGluZGV4IDc1ODY3
M2IwMjkwYS4uYTllYzM3Mjc4YjJkIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2ZwZ2Ev
ZGZsLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gPiA+IEBAIC0xMjQ4
LDcgKzEyNDgsNyBAQCBzdGF0aWMgaW50IHBhcnNlX2ZlYXR1cmVfcG9ydF9hZnUoc3RydWN0IGJ1
aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbywNCj4gPiA+ID4gIHJldHVybiBjcmVhdGVfZmVh
dHVyZV9pbnN0YW5jZShiaW5mbywgb2ZzdCwgc2l6ZSwgRkVBVFVSRV9JRF9BRlUpOw0KPiA+ID4g
PiAgfQ0KPiA+ID4gPiAgDQo+ID4gPiA+IC0jZGVmaW5lIGlzX2ZlYXR1cmVfZGV2X2RldGVjdGVk
KGJpbmZvKSAoISEoYmluZm8pLT5mZWF0dXJlX2RldikNCj4gPiA+ID4gKyNkZWZpbmUgaXNfZmVh
dHVyZV9kZXZfZGV0ZWN0ZWQoYmluZm8pICgoYmluZm8pLT50eXBlICE9IERGTF9JRF9NQVgpDQo+
ID4gPiANCj4gPiA+IEkgc3RpbGwgZG9lc24ndCBnZXQgd2h5IHB1dCB0aGUgY2hhbmdlIGhlcmUu
IEhvdyBpdCByZXNvbHZlcyBteSBjb25jZXJuDQo+ID4gPiBjb21wYXJlZCB0byB2Mz8NCj4gPiAN
Cj4gPiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHlvdXIgY29uY2Vybj8gSSBtb3ZlZCB0aGlzIGNo
YW5nZSBpbnRvIGENCj4gPiBzZXBhcmF0ZSBjb21taXQgc28gdGhhdCBpdCBpcyBub3QgbG9zdCBp
biBvdGhlciBjaGFuZ2VzLCBidXQgSSBkb24ndA0KPiANCj4gSSBkaWQndCBtZWFuIHRoaXMgY2hh
bmdlIGhhZCB0byBiZSBzZXBhcmF0ZWQsIEkgZG91YnQgaXQgaW1wYWN0cyB0aGUNCj4gZnVuY3Rp
b25hbGl0eSB3aGVuIGl0IHdhcyBhcHBsaWVkLiBBZnRlciB0aGUgc2VyaWVzIHdlcmUgYWxsIGFw
cGxpZWQgdGhlDQo+IGlzc3VlIG1heSBiZSBmaXhlZCBidXQgcGVvcGxlIHJldmlldyBwYXRjaGVz
IG9uZSBieSBvbmUuDQo+IA0KPiA+IHNlZSBob3cgdGhlIHR3byBkZWZpbml0aW9ucyB3b3VsZCBu
b3QgYmUgZnVuY3Rpb25hbGx5IGVxdWl2YWxlbnQuIFdvdWxkDQo+ID4gaXQgaGVscCB0byBleHRl
bmQgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBhbG9uZyB0aGUgZm9sbG93aW5nIGxpbmVzPw0KPiA+
IA0KPiA+ICAgIDEuIEJlZm9yZSB0aGlzIHNlcmllcywgYmluZm8tPmZlYXR1cmVfZGV2IHdhcyBp
bml0aWFsaXplZCB0byBOVUxMIGJ5DQo+ID4gICAgICAgZGV2bV9remFsbG9jKCkgaW4gZGZsX2Zw
Z2FfZmVhdHVyZV9kZXZzX2VudW1lcmF0ZSgpLiBBZnRlciB0aGlzDQo+ID4gICAgICAgc2VyaWVz
LCBiaW5mby0+dHlwZSBpcyBpbml0aWFsaXplZCB0byBERkxfSURfTUFYIGluDQo+ID4gICAgICAg
ZGZsX2ZwZ2FfZmVhdHVyZV9kZXZzX2VudW1lcmF0ZSgpLg0KPiA+ICAgIDIuIEJlZm9yZSB0aGlz
IHNlcmllcywgYmluZm8tPmZlYXR1cmVfZGV2IHdhcyBzZXQgdG8gYSBub24tTlVMTA0KPiA+ICAg
ICAgIHBvaW50ZXIgaW4gYnVpbGRfaW5mb19jcmVhdGVfZGV2KCksIHdoaWNoIGluIHR1cm4gd2Fz
IGNhbGxlZCBmcm9tDQo+IA0KPiBTbyBhdCB0aGUgcG9pbnQgb2YgKnRoaXMgcGF0Y2gqIGlzIGFw
cGxpZWQsIGJpbmZvLT5mZWF0dXJlX2RldiAmIGJpbmZvLT50eXBlDQo+IGRvbid0IGluaXRpYWxp
emUgYXQgdGhlIHNhbWUgdGltZSwgdGhlcmUgaXMgc29tZSBnYXAgdGhlIGNhbGxlciBvZg0KPiBp
c19mZWF0dXJlX2Rldl9kZXRlY3RlZCgpIHdvdWxkIGdldCBhIGRpZmZlcmVudCByZXN1bHQsIGUu
Zy4NCj4gd2hlbiBidWlsZF9pbmZvX2NyZWF0ZV9kZXYoKSBmYWlscywgYmluZm8tPnR5cGUgaG9s
ZHMgdmFsaWQgREZMX0lEIGJ1dA0KPiBiaW5mby0+ZmVhdHVyZV9kZXYgaXMgTlVMTC4NCg0KVGhh
bmsgeW91IGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gVGhpcyBhbmQgdGhlIHN1YnNlcXVlbnQgcGF0
Y2ggaGF2ZQ0KYmVlbiBtZXJnZWQgaW4gW1BBVENIIHY1IDE1LzE4XSwgdG8gYXZvaWQgYSB3aW5k
b3cgYmV0d2VlbiBiaW5mby0+dHlwZQ0KYWxyZWFkeSBob2xkaW5nIGEgdmFsaWQgREZMIGlkIGJ1
dCBiaW5mby0+ZmVhdHVyZV9kZXYgc3RpbGwgTlVMTC4NCg0KUGV0ZXINCg0KPiANCj4gPiAgICAg
ICBwYXJzZV9mZWF0dXJlX2ZpdSgpLiBBZnRlciB0aGlzIHNlcmllcywgYmluZm8tPnR5cGUgaXMg
c2V0IHRvIGENCj4gPiAgICAgICBub24tREZMX0lEX01BWCB2YWx1ZSwgYXMgcmV0dXJuZWQgYnkg
ZGZoX2lkX3RvX3R5cGUoKSwgaW4NCj4gPiAgICAgICBwYXJzZV9mZWF0dXJlX2ZpdSgpLg0KPiA+
ICAgIDMuIEJlZm9yZSB0aGlzIHNlcmllcywgYmluZm8tPmZlYXR1cmVfZGV2IHdhcyByZXNldCB0
byBOVUxMIGF0IHRoZQ0KPiA+ICAgICAgIGVuZCBvZiBidWlsZF9pbmZvX2NvbW1pdF9kZXYoKS4g
QWZ0ZXIgdGhpcyBzZXJpZXMsIGJpbmZvLT50eXBlIGlzDQo+ID4gICAgICAgcmVzZXQgdG8gREZM
X0lEX01BWCBhdCB0aGUgZW5kIG9mIGJ1aWxkX2luZm9fY29tbWl0X2RldigpLg0KPiA+IA0KPiA+
IFRoYW5rcywNCj4gPiBQZXRlcg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBZ
aWx1bg0KPiA+ID4gDQo+ID4gPiA+ICANCj4gPiA+ID4gIHN0YXRpYyBpbnQgcGFyc2VfZmVhdHVy
ZV9hZnUoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbywNCj4gPiA+ID4gIHJl
c291cmNlX3NpemVfdCBvZnN0KQ0KPiA+ID4gPiAtLSANCj4gPiA+ID4gMi40Ny4wDQo+ID4gPiA+
IA0KPiA+ID4gPiANCj4gPiANCg0K

