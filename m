Return-Path: <linux-fpga+bounces-940-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B39D1B7B
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 00:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00682281BAE
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3122C1946A8;
	Mon, 18 Nov 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vly0X76j"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E496153BE4;
	Mon, 18 Nov 2024 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970887; cv=fail; b=WgEB43uMc48zWJCnsME+pIJ/VfconR6S9b9hWz+ngsUmdRSNFembQou4+4nARVElYoegSX4PPUyKMul9QOCo5wLkKwEnkEy0hCkthnfoNXKSnwioEquO4ejIcZHkepEwh8RAtgTqiql9g7KgpKGoN3mvRBsOxXbDkzpfuvnUK2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970887; c=relaxed/simple;
	bh=O3RvHwESc5GrjFBYMST+bhvcOKHD8CyawYd+7nG+8YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VvMmvRPOyIzGVEcW0Fz4uW7XqtYAeCtOLnznztj2t19TXAnj8oFHEP1FO7fI/Yda28ba5kX86C0M2HgSaoIvADz3Ra+PnO6oqkVjUyLu76GKFqTTl9yOnO9pf5j+iXHvbZ/Hhhc7/I+qSnXo3Yg9j92qF/pI8xM9mbrP0EhJZns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vly0X76j; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731970885; x=1763506885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O3RvHwESc5GrjFBYMST+bhvcOKHD8CyawYd+7nG+8YY=;
  b=Vly0X76jUlBnPQhq7qo7IewDCb6aUr9cIXPyLBG+LeH/hMTZP2fEgEpI
   scVSyR5u+VF0sW/fQ8XP0zTOkNIsqObEGSKEKtHD193RPm2VZdUH7UNru
   QiXRLDdmHJgVvCZiRIyfySIUbKkeOcjpDwNTlpcpGEQ/IKyAxpu1iBOcJ
   WiN/XvlrotIVlCrL9g0AwtXIuwvpNdpgsHW1fcxYibfTY+OU5408wVKqu
   52n3bzGecAD6nkESKZnnxUBL1fowTy66LbEyOhq7wcTvyEaGBXgBDG29y
   E9la+Jj1S/xkHdwUh1mDwxv5en3CWD8Uv126cpBZyJ+05upEb67/rSK4h
   w==;
X-CSE-ConnectionGUID: wl6L+BYrRB6vXNkECxKu9w==
X-CSE-MsgGUID: CaClHdUnTGGrfzXvipcSrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31875658"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="31875658"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 15:01:24 -0800
X-CSE-ConnectionGUID: Kh6NxvqdQRiLmMXid0tR8w==
X-CSE-MsgGUID: A8c/B0DgTBuM4UPSREspmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89791307"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 15:01:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 15:01:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 15:01:18 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 15:01:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2x5ZPuhNa0JWLEjzFv4P75voMKU8G6GXYRBy/0qfPDll6E8frMA1ga1yfhtNMwYEHDt1ewA52VS1Co5d+CEKmi67Fox/Q/nxy0FoNU8L006Tp2GPgH8ouWz/5xf9T68zNcqIYKLbRyHHNH3oEG72k2UXB5fsrsdU7je56zKSffIcwJzI7/Lea16yBRolMshdXOtWm8RT3qQg7fBPrSVxR5XHLx7XGgdFynsvVGtNVzeeCMX/Gz0Dss/yqI3DIF+wrfPqSqZdVnCI0x9C/cGSQcRK6jfPThPL5n9gElI+iqgETf3PIjiDfJbK1nq7drPB81Orbxh1+tTK7BvvBJNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3RvHwESc5GrjFBYMST+bhvcOKHD8CyawYd+7nG+8YY=;
 b=AGNhCCtCKlHhHb3hOMi74z0IIsCvRW4rlRCFXzMp4pX5h3E3dwvLGJNnFad/rxJBCbtl6VjEBq715bX+I5DlXZAlHoSuxxbwAQMfnudqXTdDWw//1WyLBLURdS78A9v31F6cLLITORcraLnjGgyXQgOjpJGRr8TUiO6NDL4uDO9jNeF0tJC6Ks+IuW5eMiRSiT0iFQPR5l8eFTYTibIDUVtHFrBzQzYbs4njaWvQom2tZw/QzRunlfdvOxp0UAS+Q7WE2yOI+pja4cp9vDrMa6w5bNJCCjVRo+qY1jr0Z8yxbokKPD3DAV0O5RrirUt7Ndvk7ebWJgbzVQaedardog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 23:00:28 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 23:00:28 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
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
Thread-Index: AQHbOccl64/8e9xONU654dYn5+TbPLK9p8EA
Date: Mon, 18 Nov 2024 23:00:28 +0000
Message-ID: <bad311610de9738e88982fabc46c04b15cdc3650.camel@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
	 <20241025223714.394533-16-peter.colberg@intel.com>
	 <ZztQAsDCyRqGm6UW@yilunxu-OptiPlex-7050>
In-Reply-To: <ZztQAsDCyRqGm6UW@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: 7bbf074c-922e-4706-3fcd-08dd0824cbaa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGJ1RWZnYVZrL3RtNlRUYnJGRlBOZEwyMjVwZ0VPeisvemp2czNJVEZFbG1j?=
 =?utf-8?B?bUcva0FRQlB6Vy9nRGRmcTJYVUVFcXhqN3l0TG1sUDZ1TXQwbWFxWElXa1lI?=
 =?utf-8?B?KzYrd1hHUkZzNU1FeTAxVWRrSy96dUVMZjh4RFdVaHhaZnZZb3ZvYU1NM215?=
 =?utf-8?B?OE04bnorUklSc3VYV09RVjVZRG91M1R4MXJyajF3Y1NCbU5MZTNjOEtKQ0hs?=
 =?utf-8?B?ZXVEdWpwVnRXVStrUjAxZ2NuenRYNFh3clBSQ21UZUFSZml2dTVnYTdUZmM1?=
 =?utf-8?B?YWxZZ3RoOUdML1JsYm1VY0NRUVlwL1o3TU5WL1BKcklxV0VXcHBSS3ZhQUVj?=
 =?utf-8?B?RzhpWWFIbHEwMUhLQ3NIMUtUejB0YTFUby9rMUthZXJMRjRrQmJGN1ZwRjZP?=
 =?utf-8?B?R2xrbVVFbjk0ZFIvS0dJTWk0cGNHR2ZRcFh3amN4Uy9wMnZLYlNnWW1ZN2dY?=
 =?utf-8?B?TlM3eTh2UTdUb0RiVVdBdGxDQjVLcnluYThOdGpFaTY3aXRJdGdIZmJPeUZ0?=
 =?utf-8?B?eUdYdDFkd1p0MDkzcW1qTjkzd01UVWhEdHB4TlNPVGF6Qk1GUFZJeWVsbHNi?=
 =?utf-8?B?VDdSZmFrVEV6ak92K2RVZXRjclZkRHg3RC9ua0FRVVB1cFFENEZCb09OeXdy?=
 =?utf-8?B?bmZ3cjgza3JaeFEzaXZFbGJGRlRmT0ZuV01DeVFWK3NWaUFQeFp3QWJCNTky?=
 =?utf-8?B?aWNRay9YdXgzZzZQTGt0V1k2eHRtVjNZbVhDYjFRbjZGN1J3ME5CTVpRZ1Fz?=
 =?utf-8?B?eCs5dVRUbVFtd05oU003cTJ5L1RpakRrQWYvTWVXNmxRcFMyZWtDcC8zUEcz?=
 =?utf-8?B?TWc1V2hTTlYzZkhvUVpsZU5aYmFKK0tjM05TRlVLYURva3lUdmsyck1heUtJ?=
 =?utf-8?B?NDBWcUpZR29IOGN5VHB1ejBXVmx6TWxrK0taUTlOcmQ0V2g0WVVyaGxWWGU0?=
 =?utf-8?B?Qy9TTmwzcTRSdkFpeEMvSzBmQ0JMQTNGSWxISU1HUVpxUUNkYURrVjFtT2Nq?=
 =?utf-8?B?MFJ2YTBZWk51aE5XL1RIQkUyRmNFMDZodnpaSDk0eE5lOFZZSkd2UkplUEVu?=
 =?utf-8?B?U0Y3U0lNUERoYzdHbWQxdXRRS0tFQkFuR0J2ZStaWmZ6aTlkVXVpRzMrc1B2?=
 =?utf-8?B?UUdCb2JRckNmY0xDT2V1anZWOUNmR01CV3FoVk5XSXhVRktGTFVPdldCRnhY?=
 =?utf-8?B?U1FiNk5FcTdLNGZQRnZMOTVuMGJ6S1NLZitPeHp6SmVpaWFuejU1REwrcXlV?=
 =?utf-8?B?cXR4UWR1YkU0bEVNbnkvSXhCd3lkVWljd0djY0p5T3V3T3Q5YlNxK1QzLzc1?=
 =?utf-8?B?bnJKaDdrVzhJNEVLUWhUdk9nSnlLUHZ4cURmSWR0ZC9hU0RnNmpTZUpGSjhK?=
 =?utf-8?B?QTJKa0k2SGR2SVBoYTQ3MzRwM21GM2dlTnV4WjY4eHllSkF2NjdVZTk4c0Q4?=
 =?utf-8?B?RFg1ZVFQaDh6ckdtQ1E4WlQvMXJMcTRpVFI1VzJmZXB1YXdoc1JkcjdrbkJP?=
 =?utf-8?B?UklVNitTclJyMGJrZWcvUjF1cmhjQitENkNZU095N1NoeEh6KzhSWEVKWm0y?=
 =?utf-8?B?S1VpUnNOeGNBb1E2MVowN1BucTRRb0diUVBqMTcwTFFWY1dvSHN4OTRsakND?=
 =?utf-8?B?UTZQRUI1NEFnZW5BYnBsK1VvaG15R0NFUVQ4bHQ5ckY0VEMrbmlsWEkvR25y?=
 =?utf-8?B?cGgwaC9JcW5JVVJMbmZ2ZUVyS3RHUDNsRkJoYy9wVkg0c0x4V0NNUURabitU?=
 =?utf-8?B?ODYxTDhRR0FHcm5rRmdnTDJHSGFoVGgvT1FyZjdXUUlkRVVadVJXNGdWRWRW?=
 =?utf-8?Q?2zCqNbB3oVio9u6yPCYRGP65JuCE4KxliNalo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE5sYnc3ek01U0Q5MUUycUVYM05teCs3Wmpvdzd6OHdNNjR4cjI5L3d0NmNX?=
 =?utf-8?B?Vzk3V3MyWkVjL1dPOGhtMTR2bTVQRzFTN3J5Z3F5SkhaSGowMmg2bUxSTHdY?=
 =?utf-8?B?K2lRb0lETWtZaDJnTzNUL0paNk9MMGp0TG9JUXRQZzJNOWJCRTlqeWRXVHZx?=
 =?utf-8?B?U2pZRXNQR0ViaW9nVGtabm1RN2YvUnpUOEQxaTIxeXBGQ0F2M2QySzltL2xD?=
 =?utf-8?B?L1JHOTRGdFF3Z3hKbWVQU3k1RDFCMmRtR3JFNXd1b1hPT0MreUYxMFdLSmt1?=
 =?utf-8?B?MkE1WUF4SGtYNFJqdWZ0Ujk2VFZWT05EclJZMVBXTVNGcHVUZHRTOGgwcWI4?=
 =?utf-8?B?S3J2dmcyMG9LSVhZc3BQeUJwa205b2h4UGFMSytZdS9YQjUrK29mV25GWXkw?=
 =?utf-8?B?eE5yQXlrYms3bzRqa3RzOTREQTRlMDU3Rll3dUtPY1ZwSExtUkpHOTRYQnRO?=
 =?utf-8?B?ZnNYSklVcDFqYjBsQWh2dlNUT2dlN3IxdFdBdHpHVHdjcldzcVdaVzhLTzdE?=
 =?utf-8?B?UkpQQ21uYVBtMmYycDBYOUF5OE1NMlhKK0tyVno1Q1FPdi9ZWWZJNkZ4SHRW?=
 =?utf-8?B?MDJwcEFKL1lsZjEwUUhyRDhGZ2pwNnlnU3lXd0lPbkNuWnNUc0V1M0pHK1Vi?=
 =?utf-8?B?c2RHQk1HUjJHc0FTVHkzVitrR2wwUGZVZmp5dDdKczVhZFJ6YStMQU1hMVJj?=
 =?utf-8?B?ajMrSVB0UE15T0w2QXVKM01YRklJU3NWT2R1c0FtdXREVVhlcUZVQVM0SUVw?=
 =?utf-8?B?NnpoZXAxMnZDM2ZBa0paV2FvZm4yMVEwTHNsMUI3STJDdWtNajNSblpMajk4?=
 =?utf-8?B?b0JES2hrK3NFdE55WDdsbmo3eElidE15ZDNSOEFQR1lvZ3NwVXpyemd4R1Nn?=
 =?utf-8?B?Snp2QnBhbUg2d091aFNLTEt1dHNHTTQvNUJOMkVsUUtGVlRma0Y2MkZXcVpV?=
 =?utf-8?B?MytKRzNCUVJ5aXBlb3lNcWpCelR5a1hnZGEyRUhuUmswaTk0Vm9qb1pWVnYx?=
 =?utf-8?B?M2wyaEJ3STdEd1l6UkhOQ1FTZk5PdHd3ZTVxOGt1Q0QrQVJyYlFZTkx3YlJi?=
 =?utf-8?B?Y20zOHRta0MyS1N0QStPZU9BQ0huS0hqdlhiSnlvamFMdlVlRS9DUlRJSjF1?=
 =?utf-8?B?NDN3YmpZemdObzVLMU9xeDl2enk2b2R0ZUNsOVhoQnhzMWRPUUEyaXpSY2pk?=
 =?utf-8?B?UW5GY2NIdmRaV3dkNGdCWFk0bEhZNi9pSVZQMGlJQ05qdWcxZjNVSm5oZ3BR?=
 =?utf-8?B?bytVem1FQ1NYeUlJWnptM0VTeWp6ZExEMjNYU2ptd1pJR3hKemtBNjFlcHJx?=
 =?utf-8?B?c3AzdS9BNUtOK3RTZEV3VlloeXIyQjdnU29ZQ2Ewd0ZpQzNxek4yR2N6eFdu?=
 =?utf-8?B?WkdLdmpsbGZKUTVnUGVWTUVDcnEvLzl6ZklBeVA5L213a1ZpRkhuOXo3RHVJ?=
 =?utf-8?B?K24wUUd2NVp0b0RDeG1EWUZxSHZFclNodlVUbDM1QlNsSEpJUVFNOW8vcnlF?=
 =?utf-8?B?VTBncTUvVDl2R3NkcXl2VEN4ZjN0KzE5OFhGMnNiT2hOYnhSUCtrQjZOZ0tW?=
 =?utf-8?B?c0hCeHdmTzFOa1ZDUVNxRHZya3RLNExSTGE5azNYT1BTOEM5WUY0U3dUWmFm?=
 =?utf-8?B?djVRR1ZvcmsraW9xaFUxdzUrOUs0dkNaL1VOa2d2Y2RxK1NocEFkalpQMG9h?=
 =?utf-8?B?NzcvVmxwcFVMY3pRMktOM2RkTkVuSmVlcjhKVWNPREZIV3ArWWxBd293RHgy?=
 =?utf-8?B?WVZkUnhwVmhqaGlnMHovam9KLzNsSkJMLzQ3VUtQUW00ZXkzNGZ0NDZWZ0Iz?=
 =?utf-8?B?Z0NiU1pGcG5zWjllT0RqQmV3V1ArRnBVRGRmYmF4cjZ0aXFZSm9ReWZ1dTRm?=
 =?utf-8?B?Sldxc09HM1lDTERJdU9IZ1J2Y3RxSm9Fc0Erd0hyS2JlYkJFbXZ2WkQxYkNH?=
 =?utf-8?B?MVBwcGRzU3hDcHlnNVA5anZxUVoyQVhWczRaWm5ZTlY2ank0SVpPNEpkSzNU?=
 =?utf-8?B?cVNON0dadzh5WTg4QkttS0FBZXFsM3ZjcEZ5a0pnaXY2TjV3WkMyUWJCRVhS?=
 =?utf-8?B?RHVvbUk1bWFxSUpTalpDRnc3clUwM0hUd0VRc2JvMFNPS3RWbjd6cXBXa2Rk?=
 =?utf-8?B?ZTg5TXpjU1B0ZjNmbGZScGZ2WThDREpyaHJrZmJ3NXJOcWJ1Q3dkYkticFJ3?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE1C8169BC1F0F45ACCF2326272FC044@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbf074c-922e-4706-3fcd-08dd0824cbaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 23:00:28.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlgS7o8eJW38QbaJbc64tV4j66rCKD30yOBeD09kQFxfuK0qtkxNNXIXTr+QpYZ94+lYjZJSXzLgEYKbcEx5xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTE4IGF0IDIyOjMyICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMjUsIDIwMjQgYXQgMDY6Mzc6MTBQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBVc2UgYmluZm8tPnR5cGUgaW5zdGVhZCBvZiBiaW5mby0+ZmVhdHVyZV9kZXYgdG8g
ZGVjaWRlIHdoZXRoZXIgYQ0KPiA+IGZlYXR1cmUgZGV2aWNlIHdhcyBkZXRlY3RlZCBkdXJpbmcg
ZmVhdHVyZSBwYXJzaW5nLiBBIHN1YnNlcXVlbnQNCj4gPiBjb21taXQgd2lsbCBkZWxheSB0aGUg
YWxsb2NhdGlvbiBvZiB0aGUgZmVhdHVyZSBwbGF0Zm9ybSBkZXZpY2UNCj4gPiB0byBmZWF0dXJl
X2Rldl9yZWdpc3RlcigpIGFuZCByZW1vdmUgYmluZm8tPmZlYXR1cmVfZGV2Lg0KPiA+IA0KPiA+
IFRoaXMgY29tbWl0IGRvZXMgbm90IGludHJvZHVjZSBhbnkgZnVuY3Rpb25hbCBjaGFuZ2VzLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50
ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNYXR0aGV3IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFj
aEBsaW51eC5pbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEJhc2hlZXIgQWhtZWQgTXVkZGVi
aWhhbCA8YmFzaGVlci5haG1lZC5tdWRkZWJpaGFsQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+IC0gTmV3IHBhdGNoIGV4dHJhY3RlZCBmcm9tIGxh
c3QgcGF0Y2ggb2YgdjMgc2VyaWVzLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2ZwZ2EvZGZsLmMg
fCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvZGZsLmMgYi9kcml2ZXJzL2Zw
Z2EvZGZsLmMNCj4gPiBpbmRleCA3NTg2NzNiMDI5MGEuLmE5ZWMzNzI3OGIyZCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMN
Cj4gPiBAQCAtMTI0OCw3ICsxMjQ4LDcgQEAgc3RhdGljIGludCBwYXJzZV9mZWF0dXJlX3BvcnRf
YWZ1KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8sDQo+ID4gIHJldHVybiBj
cmVhdGVfZmVhdHVyZV9pbnN0YW5jZShiaW5mbywgb2ZzdCwgc2l6ZSwgRkVBVFVSRV9JRF9BRlUp
Ow0KPiA+ICB9DQo+ID4gIA0KPiA+IC0jZGVmaW5lIGlzX2ZlYXR1cmVfZGV2X2RldGVjdGVkKGJp
bmZvKSAoISEoYmluZm8pLT5mZWF0dXJlX2RldikNCj4gPiArI2RlZmluZSBpc19mZWF0dXJlX2Rl
dl9kZXRlY3RlZChiaW5mbykgKChiaW5mbyktPnR5cGUgIT0gREZMX0lEX01BWCkNCj4gDQo+IEkg
c3RpbGwgZG9lc24ndCBnZXQgd2h5IHB1dCB0aGUgY2hhbmdlIGhlcmUuIEhvdyBpdCByZXNvbHZl
cyBteSBjb25jZXJuDQo+IGNvbXBhcmVkIHRvIHYzPw0KDQpDb3VsZCB5b3UgZWxhYm9yYXRlIG9u
IHlvdXIgY29uY2Vybj8gSSBtb3ZlZCB0aGlzIGNoYW5nZSBpbnRvIGENCnNlcGFyYXRlIGNvbW1p
dCBzbyB0aGF0IGl0IGlzIG5vdCBsb3N0IGluIG90aGVyIGNoYW5nZXMsIGJ1dCBJIGRvbid0DQpz
ZWUgaG93IHRoZSB0d28gZGVmaW5pdGlvbnMgd291bGQgbm90IGJlIGZ1bmN0aW9uYWxseSBlcXVp
dmFsZW50LiBXb3VsZA0KaXQgaGVscCB0byBleHRlbmQgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBh
bG9uZyB0aGUgZm9sbG93aW5nIGxpbmVzPw0KDQogICAxLiBCZWZvcmUgdGhpcyBzZXJpZXMsIGJp
bmZvLT5mZWF0dXJlX2RldiB3YXMgaW5pdGlhbGl6ZWQgdG8gTlVMTCBieQ0KICAgICAgZGV2bV9r
emFsbG9jKCkgaW4gZGZsX2ZwZ2FfZmVhdHVyZV9kZXZzX2VudW1lcmF0ZSgpLiBBZnRlciB0aGlz
DQogICAgICBzZXJpZXMsIGJpbmZvLT50eXBlIGlzIGluaXRpYWxpemVkIHRvIERGTF9JRF9NQVgg
aW4NCiAgICAgIGRmbF9mcGdhX2ZlYXR1cmVfZGV2c19lbnVtZXJhdGUoKS4NCiAgIDIuIEJlZm9y
ZSB0aGlzIHNlcmllcywgYmluZm8tPmZlYXR1cmVfZGV2IHdhcyBzZXQgdG8gYSBub24tTlVMTA0K
ICAgICAgcG9pbnRlciBpbiBidWlsZF9pbmZvX2NyZWF0ZV9kZXYoKSwgd2hpY2ggaW4gdHVybiB3
YXMgY2FsbGVkIGZyb20NCiAgICAgIHBhcnNlX2ZlYXR1cmVfZml1KCkuIEFmdGVyIHRoaXMgc2Vy
aWVzLCBiaW5mby0+dHlwZSBpcyBzZXQgdG8gYQ0KICAgICAgbm9uLURGTF9JRF9NQVggdmFsdWUs
IGFzIHJldHVybmVkIGJ5IGRmaF9pZF90b190eXBlKCksIGluDQogICAgICBwYXJzZV9mZWF0dXJl
X2ZpdSgpLg0KICAgMy4gQmVmb3JlIHRoaXMgc2VyaWVzLCBiaW5mby0+ZmVhdHVyZV9kZXYgd2Fz
IHJlc2V0IHRvIE5VTEwgYXQgdGhlDQogICAgICBlbmQgb2YgYnVpbGRfaW5mb19jb21taXRfZGV2
KCkuIEFmdGVyIHRoaXMgc2VyaWVzLCBiaW5mby0+dHlwZSBpcw0KICAgICAgcmVzZXQgdG8gREZM
X0lEX01BWCBhdCB0aGUgZW5kIG9mIGJ1aWxkX2luZm9fY29tbWl0X2RldigpLg0KDQpUaGFua3Ms
DQpQZXRlcg0KDQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQo+IA0KPiA+ICANCj4gPiAgc3RhdGlj
IGludCBwYXJzZV9mZWF0dXJlX2FmdShzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJp
bmZvLA0KPiA+ICByZXNvdXJjZV9zaXplX3Qgb2ZzdCkNCj4gPiAtLSANCj4gPiAyLjQ3LjANCj4g
PiANCj4gPiANCg0K

