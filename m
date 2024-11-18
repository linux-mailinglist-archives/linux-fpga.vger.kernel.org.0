Return-Path: <linux-fpga+bounces-941-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689809D1B95
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 00:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4694B22A1F
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF681E5728;
	Mon, 18 Nov 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHe/jYON"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8B1D0DDE;
	Mon, 18 Nov 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731971068; cv=fail; b=ZQhSB5NjLPgr0ZVjVry4krimH2RkkGJP+Kx0KIQNoVSIUMKa6VAqdXFt/ugLZ1TNE8T35QmIGiRH2TLFY/11WZTOPEF7q3zZLNR38EXs06JdRyESI+S3jxTsxTZlwAoRpGFqE+J0D7s5uv6GReh0LY3g6cwVspv01jmxyItEY+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731971068; c=relaxed/simple;
	bh=6vw8CznvZWLdKMCghExANDuN4hxKF/PLSJ5fgR7BceY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Um6m97eWW0B4uaejpdDeFXAoAXiwFnps4kN1uLpl2AbOOvs+TXTsKwmkyeM9FqGW7YTdyLYFH3pn3uURNf6du7Lgjr+3EJP13ta1qRui9CMa4bKZC2bUBVQrdrPIyc6wv57Dk2QepqeJS9tUEZbzdKMW04pvtaaPe08Wh1rBnuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHe/jYON; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731971067; x=1763507067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6vw8CznvZWLdKMCghExANDuN4hxKF/PLSJ5fgR7BceY=;
  b=ZHe/jYONosvZGPg2I6Xcxq+8PxglWvQvac2h0NgM6+MOfi5MRW7P/qrS
   XlH3M71YDijX6PilBNCur/3Ne/yNFRLtNlzXRADuLy5/lSQwl2apvjnLh
   lgeOdVUP4P3SOtyijjlrOWtefbmC3VEF/JjH9Ir7kd5k2r2t6K1o2ybsA
   FKhBc3RF8uu0wjb39WpBVDgm/5sP7CYzwZKZy1QBYowRM8z65fr1aFhzm
   xR2aSNCFEdjoqajTtPJwOlAW6Oh1f1NFPu8CbUQk//SeKCOuxyGqFJTL1
   O/Yl62XcKER44Bh0r+DXDChfx6+t+FYpTHUyk+3ql7Nf6PitR79/lG3jk
   Q==;
X-CSE-ConnectionGUID: haBf7qLKRHCnk9GgLaBcfw==
X-CSE-MsgGUID: RpVl4LurQz2eMlPhrjnD6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31886850"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="31886850"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 15:04:26 -0800
X-CSE-ConnectionGUID: T1X1tzqDQ82gNBZkQ39T3A==
X-CSE-MsgGUID: ZoVB3Q4RSe6fEdGzuuhbAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94416053"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 15:04:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 15:04:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 15:04:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 15:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kraA5mETL4FzSigpUDXY2q+zzufN93gGESImOFW0ImVFws+SoarqxEI5AToV3NhybM6rwxfA0jA9+9Uj41Oul1MCx3jjdfwt89rNicI0fDwv5w4JWBL4XoEgce53cZQ1L40Thc+g5c5TS7QDznUIOM1XacREHUks1zBgM0I8vVOvu3qyC9Xvskdn0qyomALItHDVDma9sgpJAyX0UIYbRJINOmFr210COJCgplpaf4zwCm98FpV1ZYV0wtE0g/dwM42Gej26XPo1l9qDn6ndbCBtE7T71kMuDOHVdRJPNow8TBYd1+8VXq0bQP5EfceGCsSd4UzI817AxdqmgQIChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vw8CznvZWLdKMCghExANDuN4hxKF/PLSJ5fgR7BceY=;
 b=y5Aez8Ui1D/elok/IXdqttTC8tgssqt8p47F/QrZpp92OswrEFn70zxGPJEWo4LUqg9DPloL4mSpL7E84KVoQFsqqqBgCaWGhqzrWvT7AlFToxHrOdxcmXkgYnW+fV0NhtVaNMXbnCJ+kI1eE1Ih7kk0u5gQ1IJv2IwbmjTf+4r5xxIRPZtMzH35SyAg8Dg0GmP8hHwxTVdMWvkx9f7mVWJppd2gtEQweV90m77M6rxtPItq6jtAnhA/+43iDLFvrUMieqEnGePaX0D3cKxCHH8hYE4/3zXv7Yz+hQ37TxgDwjoABuBVQmjS+3StOgPs8QT8eLiG8nD7bBPFJOsUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 23:04:15 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 23:04:15 +0000
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
Subject: Re: [PATCH v4 16/19] fpga: dfl: allocate platform device after
 feature device data
Thread-Topic: [PATCH v4 16/19] fpga: dfl: allocate platform device after
 feature device data
Thread-Index: AQHbOcnUwiIBOsgtgEK/p85b3czA1rK9qMqA
Date: Mon, 18 Nov 2024 23:04:15 +0000
Message-ID: <4002f681655dce0aa9ec0cceca744f237f392c81.camel@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
	 <20241025223714.394533-17-peter.colberg@intel.com>
	 <ZztUfN8ySl0ck3h4@yilunxu-OptiPlex-7050>
In-Reply-To: <ZztUfN8ySl0ck3h4@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: f89d22b2-e213-426e-31e8-08dd082552e3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVlibGJBdWV4S3pPbXVwTy9ZUzBZenJEL1dXNWJmWVVpNXlXa0VhcEFGT01y?=
 =?utf-8?B?WTQxT0s5VDhBRkFJWUM5OEt6NEpCNCtsN0lpTkExY2gwZEhhbU4wU293dWtI?=
 =?utf-8?B?bUR1NndkR0VnQU8rZjBJZGFnbUlSRHZGcVQrTHJFQW9nMnJqK1RKYUJkTVNj?=
 =?utf-8?B?enZlOTEzeWlvd2xCM1pQTkJmODUrb0lpbmdXNDc0eGNuOTB4MXRITGlINkFz?=
 =?utf-8?B?UGpIYkpzbWZ5K1pnL0tIb050TldoaUpIeS9HUi9tMHBTYUp4dndhT0JxRVIz?=
 =?utf-8?B?cm95cDZuNy9DN09seU1aWVhpNmNEWUlWczJiZmZ5djYreGIxTTIxV3pSdnlC?=
 =?utf-8?B?MmJGQzR4MDdqU2Jkd1RxL2FxL2w3ajltWDJUWEVLZ016WEQ5NU5HWHdtSStY?=
 =?utf-8?B?cDc0N0x3SnNldEt6bzlpbzlka0tRK0RyZVdhYUZXUUxEeCtob3F2M0l5bnlI?=
 =?utf-8?B?aEtPL2RFSHR2a0xRMjB1VytPWitxeUVMbHJOMjZ4blJTV2pDc3J1ZXV6dVQx?=
 =?utf-8?B?dnYwc0lEZUpQcU5CNFoxbXp2TE84NjVwWlIzaUlrYXN6T0FOM3FqTTdhb2U2?=
 =?utf-8?B?TzI1TkI3RVpaTE5xczdJc2VKb2szK2dYaG9OdGFIRytqZ255WWtvc2ZJWlA5?=
 =?utf-8?B?azRneWUxKzlpYWFnbW5IMzMza2c0Q2tCTWpEUDkxZi9rWWxCQllTYVFiVmJM?=
 =?utf-8?B?YllyVDhwcXdId3ltRFpaOTVJRVl6Wk0za3lnOXNLTkUreU4zTHhMYk0rcmZJ?=
 =?utf-8?B?TkRwYkY0ejRpc1hMZ3k1OHo5K0Z1VGcwWDBaRUs4REQvOHViRnNyaVZXZEVC?=
 =?utf-8?B?cThuTGttaFRzL2tKNGFWbGdMZjZ5Y210WmRtaTVINXc5RlBVenhDUnFaYmQv?=
 =?utf-8?B?UFF6dmcweGZSem9TMk5NM2M3dW9UN1hwSi9WMW43ZXRFZFRVN2RUbkg5VEda?=
 =?utf-8?B?WHVXYkxLOUpIOVpoWkFCYkZGdjVoeGM0UUg4ay9Jc3VkbmFheXQxM0NoSXk3?=
 =?utf-8?B?anhYeUdXaCtEV0NlZG4xVEx4SndyREQ3VTJSa2U2cjdBcEQzR2Fwd0ZDekIy?=
 =?utf-8?B?STZIVHM4L0dTbUJhZjE2dVNtSEFtK0FWKzBTRE0ybGJPeUU1aEg5amR3WU5O?=
 =?utf-8?B?RXFob0M1R2pYUk5pRzB6UG03MmhGbXZueWRzR0daRHJsa2cramNyOVAyck15?=
 =?utf-8?B?NjBybVJLaVcrelRWUXVjK0FTRG9OdGdMUi9vTTR2REtLWk1WYzJuSWRxWldo?=
 =?utf-8?B?STUvRDBzNHpZSmVueUpiMlVEUWFSTTdTdS9KUk5SdExVc203YXRaSXlSUmVE?=
 =?utf-8?B?SklEWHVNcUJXVlJVZnZNSVFaVGxKN1NXUTNxL0V1YmhpdU45cTdYRVB5bEZr?=
 =?utf-8?B?elJjNWlvczNrZW1odFZXaHVPNEdZSTlyQmZLKzdWcGtUV09pU3hIUjNkNmRw?=
 =?utf-8?B?WXp0cnA0a3RtRVlEUTFLVE5NRGR6RFVlaDhLdUlGK1ZMZ04zQ1JnVlRvSHM3?=
 =?utf-8?B?Q3dBWWU0Qy9jck40andKWGlRQXF1Y29KMFFGclV0WVNhS2d4cEcxY2tPNFdo?=
 =?utf-8?B?VEVEMkluT3RQVnFVY21TRW9kdFFaQW50dUhTSFcxTk5yUGJZREFtbFJTVnFa?=
 =?utf-8?B?SmdaTXduNFd5dDE4ZU11dGJlRlZMeFZkdDl3VjN6dVhjUHhhbFgxVnh4bjVm?=
 =?utf-8?B?VUYwV1Y4cEZ1cnl1RzFvSVJVc1haclBpL3ZFTFBodkNsbk1ZbTcvZy83dDJo?=
 =?utf-8?B?TmlQUFJzcXR2WUhrSHA4OExhSUQ2RjdyYU43emZwajNpeWI4dVNabnBjVnJT?=
 =?utf-8?Q?YPk8K3Oqr3Bu1Nbp6C7hdwMgvlYNweADvPEIE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjgwWU5xMmZNdWtqcDhOLzlVdFdZZ3VPaHNUVEZ1YzU1bUFSTHB2WitUUHNV?=
 =?utf-8?B?WWpUYUxhRUswNk5ZVGYrTHAvM2JwbldPNjRlajdENUdsbEw5ZUZya0J5N0N6?=
 =?utf-8?B?Uk5tZmFnUyt2VXIwZkhuVXJmbUVPaTlxckk0Vnl1TnUyeEErQUNNYTlQYlhP?=
 =?utf-8?B?VmVnclNTQytNWUJKQTdLUHJ3K092b0p4QjhpZnk1TG5tdTl1Z3hOcStwRHZo?=
 =?utf-8?B?eUJhd3F2dGw5bk02NDJHSDVMTHdiMlJJL2VCbk9mcW1zSmxrOHVnc1J2QzZT?=
 =?utf-8?B?dDIySnh4RGpvRkU1dDlZQTA3UTAyb3RUUk84VlB5bGQ4VktCRnRXaHNzNW84?=
 =?utf-8?B?MVJ5NWdDNmdpU0tHbW1KSlBxNDk5alNKYjRZUmZmQ1hSOUJ3R1QwY0JBTHcw?=
 =?utf-8?B?MjBrNlNpaFhWSGtmNHZFcmV2c2l1OUlRVUMrV1pCb3pGRHhUYjFUWUJWQUF2?=
 =?utf-8?B?T005UWlmMFp6SXJBRTIvdGdmaUF2MitDSjV3MDJZSUR6Ky9GYTN6VjlLT3k1?=
 =?utf-8?B?ZitsSENnd3dhT0E3eTJEYzVWVHNzNEwzdmRpM2lVWGJ1Mk14aDc3RHVjUWNu?=
 =?utf-8?B?WVp0S25oazBhSm84alVmYzF2Rk4ydnROSHEwK1JPbFllV3ZVR1pCSVd5RDk2?=
 =?utf-8?B?eDZtUU11Mk5PVldIWjJUY2ZxWjNnQ1pvUmpmUmJhbmptUmtGaHhGUm14NVU1?=
 =?utf-8?B?V21sT2FjU24vamU4MUg0ZnhySmMrRzkzbFFCeXFiZjFXdTBsUXhFY3F5R0pU?=
 =?utf-8?B?MnlTc3JKSDJnWTNVZGViemttV2tRVldoRTBBaWlBM1U1UE15YUlOQkFGbk95?=
 =?utf-8?B?RldrdzErSkZsUHNZVkt2a0xPRGdEQU03U3BNcEJkdmVZNUVnaXplb0oyNmZQ?=
 =?utf-8?B?RU82dHJxcHd0V2ZtUUxkVDlCZlp1V01PV2ZGTlo0MnVGN2JvSnpDNFZNNVkv?=
 =?utf-8?B?MW52V3ZEUEpNbkxVMzQ1WnJvNkUzOXo3NWpSVGpwWWl0aDRoK05iUGFLV3R2?=
 =?utf-8?B?UHJOV1dxUGx4TytEclc5SWliYnMyM1lFbXpYdFZ2dWd2b1lOdU9MR3VHbGNt?=
 =?utf-8?B?TFZtUm1OM2hnZGNEZWRzUlhnSHcxaVduVDdNd2h1dXIrUGJFVk5Id1F1NWh5?=
 =?utf-8?B?TjVmZkJZVFN4Vk1pSEgvWVQxOFZ4ZXo3TUJ2TmFFeW1mMFl5b3hYUW54bXh1?=
 =?utf-8?B?K1BqdGJLSkZIK2JyTmIyNHpTQ0hwaktzTDVkMk02OHo4eFdmenZDLzVGUnNM?=
 =?utf-8?B?cjAzeFJDNUxwSjdjZU91SjQyWFV2eWVITnVUcVRaRXlLZ1hrVGlVYUpDVkFG?=
 =?utf-8?B?YXVpQ2RKTjdOMjBYZTRmdHZXOHJ5VlRGN3J6OElLWUQ2eU1lbEVnMFM5NzRX?=
 =?utf-8?B?STNCdytlMnBkTHpJeHVhVFdrKzhzby9wMDkvTTNYY1MvSGUydXhJcURCcXZu?=
 =?utf-8?B?cUZLaTJ4Q1ZRZWJCS3lLY3RNTGhQelF2S3pzN2haczR1SlVnZ2FvaDR5NXNT?=
 =?utf-8?B?TXlGQmFzdXI3NHNwbllWZHU3S29QOEZKSzI4ZjBScjVTTWQzcEhvZ3Nlditw?=
 =?utf-8?B?dURWc2tDWHlhRkYvcFBHMGhtK2x1Y2VZNkxUZWVpc3JYWktZZnZmMzV0anpu?=
 =?utf-8?B?OTB5R2l1dVByaCtnc0paSG5ZRS8xMmZvN3NRaEFmMnR0YlN5Y2N2a1lQWGFI?=
 =?utf-8?B?Z09TSXpYU1lMc1U2UERJakZXVkg0ZUl6eXdHcGhpb1phdElSbWtMRkJTZ0hH?=
 =?utf-8?B?NU9oUzR0QURIUUxyRVNkTm5XckFQampocmhjbkdHREcra1pVZUJvYWxDNmcz?=
 =?utf-8?B?SUxDZGh6N1hENitpN2x5VllMY2V0VlJ4RUlMRC9jUXFHdzRoeUJwaGVsVHdi?=
 =?utf-8?B?UktJZkFialhMZjJiaDRuVGc0a3RMTC84YXQ0U1VtS043ZytPQ3ZVMXJKYkZG?=
 =?utf-8?B?bEplYnArYjh6cm9nZ3BreVJmTmY5MVdjZi9pWTlPN1pZWDRTVWpGNzJrcUdp?=
 =?utf-8?B?TC8rZmV4eGQ3Rm5lTmpFb055V3BPWVVZNDlNOVZLV2hocWJiL3N1dy9wcUxL?=
 =?utf-8?B?N3k2VXp4L1hWM0hFK0pzYTJwVm91RjEwdlZ3QzVodklBN21sS0E3bWh0aUxQ?=
 =?utf-8?B?emkrSklMZU56ZG0zbzdTaUYxaWtYbkVZUG1jQnhxR1l3SnZvMGxzRHo4VWIy?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DADD3C381B31AE469DC97F3729406E1A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89d22b2-e213-426e-31e8-08dd082552e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 23:04:15.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rlaps/3xBIUfpjde9g4SGIH0png8ccaPDyf7pSM5Gen5VMSxKzoRYHeLeqzK3mwxxZp4wFdAMlv2m9IoskypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTE4IGF0IDIyOjUxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMjUsIDIwMjQgYXQgMDY6Mzc6MTFQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBEZWxheSBjYWxsaW5nIHBsYXRmb3JtX2RldmljZV9hbGxvYygpIGZyb20gYnVpbGRf
aW5mb19jcmVhdGVfZGV2KCkgdG8NCj4gPiBmZWF0dXJlX2Rldl9yZWdpc3RlcigpLCBub3cgdGhh
dCB0aGUgZmVhdHVyZSBkZXZpY2UgZGF0YSBjb250YWlucyBhbGwNCj4gPiBuZWNlc3NhcnkgZGF0
YSB0byBjcmVhdGUgdGhlIGZlYXR1cmUgZGV2aWNlLiBUaGlzIGNvbXBsZXRlcyB0aGUgbmV3DQo+
ID4gZnVuY3Rpb24gZmVhdHVyZV9kZXZfcmVnaXN0ZXIoKSwgd2hpY2ggd2lsbCBiZSByZXVzZWQg
aW4gYSBzdWJzZXF1ZW50DQo+ID4gY29tbWl0IHRvIGZ1bGx5IHJlY3JlYXRlIHRoZSBmZWF0dXJl
IGRldmljZSB3aGVuIGFzc2lnbmluZyBhIHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
UGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogQmFzaGVlciBBaG1lZCBNdWRkZWJpaGFsIDxiYXNoZWVyLmFobWVkLm11ZGRl
YmloYWxAbGludXguaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgdjM6DQo+
ID4gLSBOZXcgcGF0Y2ggZXh0cmFjdGVkIGZyb20gbGFzdCBwYXRjaCBvZiB2MyBzZXJpZXMuDQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvZnBnYS9kZmwuYyB8IDU5ICsrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2ZwZ2EvZGZsLmMgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPiBpbmRleCBhOWVjMzcyNzhiMmQu
LmQ5Y2VmMTUwZWQwZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4gPiBAQCAtNjgxLDcgKzY4MSw2IEBAIEVYUE9SVF9T
WU1CT0xfR1BMKGRmbF9mcGdhX2Rldl9vcHNfdW5yZWdpc3Rlcik7DQo+ID4gICAqIEBucl9pcnFz
OiBudW1iZXIgb2YgaXJxcyBmb3IgYWxsIGZlYXR1cmUgZGV2aWNlcy4NCj4gPiAgICogQGlycV90
YWJsZTogTGludXggSVJRIG51bWJlcnMgZm9yIGFsbCBpcnFzLCBpbmRleGVkIGJ5IGxvY2FsIGly
cSBpbmRleCBvZg0KPiA+ICAgKgkgICAgICAgdGhpcyBkZXZpY2UuDQo+ID4gLSAqIEBmZWF0dXJl
X2RldjogY3VycmVudCBmZWF0dXJlIGRldmljZS4NCj4gPiAgICogQHR5cGU6IHRoZSBjdXJyZW50
IEZJVSB0eXBlLg0KPiA+ICAgKiBAaW9hZGRyOiBoZWFkZXIgcmVnaXN0ZXIgcmVnaW9uIGFkZHJl
c3Mgb2YgY3VycmVudCBGSVUgaW4gZW51bWVyYXRpb24uDQo+ID4gICAqIEBzdGFydDogcmVnaXN0
ZXIgcmVzb3VyY2Ugc3RhcnQgb2YgY3VycmVudCBGSVUuDQo+ID4gQEAgLTY5NSw3ICs2OTQsNiBA
QCBzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gew0KPiA+ICAJdW5zaWduZWQgaW50IG5y
X2lycXM7DQo+ID4gIAlpbnQgKmlycV90YWJsZTsNCj4gPiAgDQo+ID4gLQlzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpmZWF0dXJlX2RldjsNCj4gPiAgCWVudW0gZGZsX2lkX3R5cGUgdHlwZTsNCj4g
PiAgCXZvaWQgX19pb21lbSAqaW9hZGRyOw0KPiA+ICAJcmVzb3VyY2Vfc2l6ZV90IHN0YXJ0Ow0K
PiA+IEBAIC03NTAsNyArNzQ4LDYgQEAgc3RhdGljIHZvaWQgZGZsX2lkX2ZyZWVfYWN0aW9uKHZv
aWQgKmFyZykNCj4gPiAgc3RhdGljIHN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAqDQo+ID4g
IGJpbmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNf
aW5mbyAqYmluZm8pDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmZkZXYg
PSBiaW5mby0+ZmVhdHVyZV9kZXY7DQo+ID4gIAllbnVtIGRmbF9pZF90eXBlIHR5cGUgPSBiaW5m
by0+dHlwZTsNCj4gPiAgCXN0cnVjdCBkZmxfZmVhdHVyZV9pbmZvICpmaW5mbywgKnA7DQo+ID4g
IAlzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhOw0KPiA+IEBAIC03NzMsNyArNzcw
LDYgQEAgYmluZm9fY3JlYXRlX2ZlYXR1cmVfZGV2X2RhdGEoc3RydWN0IGJ1aWxkX2ZlYXR1cmVf
ZGV2c19pbmZvICpiaW5mbykNCj4gPiAgCWlmICghZmRhdGEtPnJlc291cmNlcykNCj4gPiAgCQly
ZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiAgDQo+ID4gLQlmZGF0YS0+ZGV2ID0gZmRldjsN
Cj4gPiAgCWZkYXRhLT50eXBlID0gdHlwZTsNCj4gPiAgDQo+ID4gIAlmZGF0YS0+cGRldl9pZCA9
IGRmbF9pZF9hbGxvYyh0eXBlLCBiaW5mby0+ZGV2KTsNCj4gPiBAQCAtNzg0LDggKzc4MCw2IEBA
IGJpbmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNf
aW5mbyAqYmluZm8pDQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiBFUlJfUFRSKHJldCk7
DQo+ID4gIA0KPiA+IC0JZmRldi0+aWQgPSBmZGF0YS0+cGRldl9pZDsNCj4gPiAtDQo+ID4gIAlm
ZGF0YS0+cGRldl9uYW1lID0gZGZsX2RldnNbdHlwZV0ubmFtZTsNCj4gPiAgCWZkYXRhLT5udW0g
PSBiaW5mby0+ZmVhdHVyZV9udW07DQo+ID4gIAlmZGF0YS0+ZGZsX2NkZXYgPSBiaW5mby0+Y2Rl
djsNCj4gPiBAQCAtODA5LDcgKzgwMyw2IEBAIGJpbmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRh
KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+ID4gIAkJdW5zaWduZWQg
aW50IGk7DQo+ID4gIA0KPiA+ICAJCS8qIHNhdmUgcmVzb3VyY2UgaW5mb3JtYXRpb24gZm9yIGVh
Y2ggZmVhdHVyZSAqLw0KPiA+IC0JCWZlYXR1cmUtPmRldiA9IGZkZXY7DQo+ID4gIAkJZmVhdHVy
ZS0+aWQgPSBmaW5mby0+ZmlkOw0KPiA+ICAJCWZlYXR1cmUtPnJldmlzaW9uID0gZmluZm8tPnJl
dmlzaW9uOw0KPiA+ICAJCWZlYXR1cmUtPmRmaF92ZXJzaW9uID0gZmluZm8tPmRmaF92ZXJzaW9u
Ow0KPiA+IEBAIC04NjgsMTggKzg2MSw2IEBAIGJpbmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRh
KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+ID4gIHN0YXRpYyBpbnQN
Cj4gPiAgYnVpbGRfaW5mb19jcmVhdGVfZGV2KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5m
byAqYmluZm8pDQo+ID4gIHsNCj4gPiAtCWVudW0gZGZsX2lkX3R5cGUgdHlwZSA9IGJpbmZvLT50
eXBlOw0KPiA+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZmRldjsNCj4gPiAtDQo+ID4gLQkv
Kg0KPiA+IC0JICogd2UgdXNlIC1FTk9ERVYgYXMgdGhlIGluaXRpYWxpemF0aW9uIGluZGljYXRv
ciB3aGljaCBpbmRpY2F0ZXMNCj4gPiAtCSAqIHdoZXRoZXIgdGhlIGlkIG5lZWQgdG8gYmUgcmVj
bGFpbWVkDQo+ID4gLQkgKi8NCj4gPiAtCWZkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoZGZs
X2RldnNbdHlwZV0ubmFtZSwgLUVOT0RFVik7DQo+ID4gLQlpZiAoIWZkZXYpDQo+ID4gLQkJcmV0
dXJuIC1FTk9NRU07DQo+ID4gLQ0KPiA+IC0JYmluZm8tPmZlYXR1cmVfZGV2ID0gZmRldjsNCj4g
PiAgCWJpbmZvLT5mZWF0dXJlX251bSA9IDA7DQo+ID4gIA0KPiA+ICAJSU5JVF9MSVNUX0hFQUQo
JmJpbmZvLT5zdWJfZmVhdHVyZXMpOw0KPiA+IEBAIC04OTUsMjcgKzg3Niw0MyBAQCBidWlsZF9p
bmZvX2NyZWF0ZV9kZXYoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4g
PiAgc3RhdGljIGludCBmZWF0dXJlX2Rldl9yZWdpc3RlcihzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2
X2RhdGEgKmZkYXRhKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1f
ZGF0YSBwZGF0YSA9IHt9Ow0KPiA+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZmRldiA9IGZk
YXRhLT5kZXY7DQo+ID4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpmZGV2Ow0KPiA+ICsJc3Ry
dWN0IGRmbF9mZWF0dXJlICpmZWF0dXJlOw0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gKwlm
ZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKGZkYXRhLT5wZGV2X25hbWUsIGZkYXRhLT5wZGV2
X2lkKTsNCj4gPiArCWlmICghZmRldikNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+
ID4gKwlmZGF0YS0+ZGV2ID0gZmRldjsNCj4gPiArDQo+ID4gIAlmZGV2LT5kZXYucGFyZW50ID0g
JmZkYXRhLT5kZmxfY2Rldi0+cmVnaW9uLT5kZXY7DQo+ID4gIAlmZGV2LT5kZXYuZGV2dCA9IGRm
bF9nZXRfZGV2dChkZmxfZGV2c1tmZGF0YS0+dHlwZV0uZGV2dF90eXBlLCBmZGV2LT5pZCk7DQo+
ID4gIA0KPiA+ICsJZGZsX2ZwZ2FfZGV2X2Zvcl9lYWNoX2ZlYXR1cmUoZmRhdGEsIGZlYXR1cmUp
DQo+ID4gKwkJZmVhdHVyZS0+ZGV2ID0gZmRldjsNCj4gPiArDQo+ID4gIAlyZXQgPSBwbGF0Zm9y
bV9kZXZpY2VfYWRkX3Jlc291cmNlcyhmZGV2LCBmZGF0YS0+cmVzb3VyY2VzLA0KPiA+ICAJCQkJ
CSAgICBmZGF0YS0+cmVzb3VyY2VfbnVtKTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gLQkJcmV0dXJu
IHJldDsNCj4gPiArCQlnb3RvIGVycl9wdXRfZGV2Ow0KPiA+ICANCj4gPiAgCXBkYXRhLmZkYXRh
ID0gZmRhdGE7DQo+ID4gIAlyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkX2RhdGEoZmRldiwgJnBk
YXRhLCBzaXplb2YocGRhdGEpKTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gLQkJcmV0dXJuIHJldDsN
Cj4gPiArCQlnb3RvIGVycl9wdXRfZGV2Ow0KPiA+ICANCj4gPiAgCXJldCA9IHBsYXRmb3JtX2Rl
dmljZV9hZGQoZmRldik7DQo+ID4gIAlpZiAocmV0KQ0KPiA+IC0JCXJldHVybiByZXQ7DQo+ID4g
KwkJZ290byBlcnJfcHV0X2RldjsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiArDQo+ID4g
K2Vycl9wdXRfZGV2Og0KPiA+ICsJcGxhdGZvcm1fZGV2aWNlX3B1dChmZGV2KTsNCj4gPiArCWZk
YXRhLT5kZXYgPSBOVUxMOw0KPiANCj4gRG8gd2UgYWxzbyBuZWVkIHRvIGNsZWFuIHVwIGFsbCB0
aGUgZmVhdHVyZS0+ZGV2Pw0KDQpZZXMsIHRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24uIEl0
IGlzIG5vdCBuZWVkZWQgZm9yIGZ1bmN0aW9uYWwNCmNvcnJlY3RuZXNzIHNpbmNlIGZlYXR1cmUt
PmRldiBpcyBleGNsdXNpdmVseSB1c2VkIHdoZW4gbm9uLU5VTEwsIGJ1dA0KaXQgc2VlbXMgYSBn
b29kIGlkZWEgZm9yIGNvbnNpc3RlbmN5Lg0KDQpUaGFua3MsDQpQZXRlcg0KDQo+IA0KPiBUaGFu
a3MsDQo+IFlpbHVuDQo+IA0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiAg
DQo+ID4gIHN0YXRpYyB2b2lkIGZlYXR1cmVfZGV2X3VucmVnaXN0ZXIoc3RydWN0IGRmbF9mZWF0
dXJlX2Rldl9kYXRhICpmZGF0YSkNCj4gPiBAQCAtOTQwLDE2ICs5MzcsNyBAQCBzdGF0aWMgaW50
IGJ1aWxkX2luZm9fY29tbWl0X2RldihzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJp
bmZvKQ0KPiA+ICAJaWYgKGJpbmZvLT50eXBlID09IFBPUlRfSUQpDQo+ID4gIAkJZGZsX2ZwZ2Ff
Y2Rldl9hZGRfcG9ydF9kYXRhKGJpbmZvLT5jZGV2LCBmZGF0YSk7DQo+ID4gIAllbHNlDQo+ID4g
LQkJYmluZm8tPmNkZXYtPmZtZV9kZXYgPSBnZXRfZGV2aWNlKCZiaW5mby0+ZmVhdHVyZV9kZXYt
PmRldik7DQo+ID4gLQ0KPiA+IC0JLyoNCj4gPiAtCSAqIHJlc2V0IGl0IHRvIGF2b2lkIGJ1aWxk
X2luZm9fZnJlZSgpIGZyZWVpbmcgdGhlaXIgcmVzb3VyY2UuDQo+ID4gLQkgKg0KPiA+IC0JICog
VGhlIHJlc291cmNlIG9mIHN1Y2Nlc3NmdWxseSByZWdpc3RlcmVkIGZlYXR1cmUgZGV2aWNlcw0K
PiA+IC0JICogd2lsbCBiZSBmcmVlZCBieSBwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcigpLiBT
ZWUgdGhlDQo+ID4gLQkgKiBjb21tZW50cyBpbiBidWlsZF9pbmZvX2NyZWF0ZV9kZXYoKS4NCj4g
PiAtCSAqLw0KPiA+IC0JYmluZm8tPmZlYXR1cmVfZGV2ID0gTlVMTDsNCj4gPiArCQliaW5mby0+
Y2Rldi0+Zm1lX2RldiA9IGdldF9kZXZpY2UoJmZkYXRhLT5kZXYtPmRldik7DQo+ID4gIA0KPiA+
ICAJLyogcmVzZXQgdGhlIGJpbmZvIGZvciBuZXh0IEZJVSAqLw0KPiA+ICAJYmluZm8tPnR5cGUg
PSBERkxfSURfTUFYOw0KPiA+IEBAIC05NjYsOCArOTU0LDYgQEAgc3RhdGljIHZvaWQgYnVpbGRf
aW5mb19mcmVlKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+ID4gIAkJ
a2ZyZWUoZmluZm8pOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCXBsYXRmb3JtX2RldmljZV9wdXQo
YmluZm8tPmZlYXR1cmVfZGV2KTsNCj4gPiAtDQo+ID4gIAlkZXZtX2tmcmVlKGJpbmZvLT5kZXYs
IGJpbmZvKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiBAQCAtMTI2Miw4ICsxMjQ4LDcgQEAgc3RhdGlj
IGludCBwYXJzZV9mZWF0dXJlX2FmdShzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJp
bmZvLA0KPiA+ICAJY2FzZSBQT1JUX0lEOg0KPiA+ICAJCXJldHVybiBwYXJzZV9mZWF0dXJlX3Bv
cnRfYWZ1KGJpbmZvLCBvZnN0KTsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4gLQkJZGV2X2luZm8oYmlu
Zm8tPmRldiwgIkFGVSBiZWxvbmdpbmcgdG8gRklVICVzIGlzIG5vdCBzdXBwb3J0ZWQgeWV0Llxu
IiwNCj4gPiAtCQkJIGJpbmZvLT5mZWF0dXJlX2Rldi0+bmFtZSk7DQo+ID4gKwkJZGV2X2luZm8o
YmluZm8tPmRldiwgIkFGVSBiZWxvbmdpbmcgdG8gRklVIGlzIG5vdCBzdXBwb3J0ZWQgeWV0Llxu
Iik7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gLS0gDQo+ID4gMi40Ny4w
DQo+ID4gDQo+ID4gDQoNCg==

