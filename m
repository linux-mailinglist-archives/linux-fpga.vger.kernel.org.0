Return-Path: <linux-fpga+bounces-945-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571909D30F8
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 00:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDA1B23F2A
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 23:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5F1D2F56;
	Tue, 19 Nov 2024 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMOyv9Te"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B041D3565;
	Tue, 19 Nov 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059294; cv=fail; b=pkMZNYtRy1cnvwFTOaqs5sW7qoLrbENyAkw9rlw6UswwG8lysxCoTVspyn2aQ2Zy/Onz0kdVI9YqhvtAVNecwec4F2DuYwS7oOIUP2dNJ6OoU8KHCvp5N3zVT4eVscR6AKE2LmryltwcNH+yGDoIqtWeK2j7Nobn0yu5pwTmQ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059294; c=relaxed/simple;
	bh=f8Yh/e3EtJBs7mN+LhA26XrTWELj0H6lIZF2+0wAX58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A11jAEMEq1smB39mEYsuJycu+wwHDqOlSkL8ynA8DeduK5k2gdgr3S2lRxo7A1wgdOhwkl2b8T1RMbgxBQx+M//3htfLkypA/W+dy2IIHk8faQMxxd8elU2v6+Ol8VFlhConXiynGa2i4Ts+r5fXxoszzk6eDlUIbFZV3GRYaCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMOyv9Te; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732059292; x=1763595292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f8Yh/e3EtJBs7mN+LhA26XrTWELj0H6lIZF2+0wAX58=;
  b=OMOyv9Te2qcOcAO7J2F5FJlQudtsb1BSdXL6lSV2sDtm+bDXMf+MkuPx
   O9/7fepnUFLLdkgABWKmWCcn3hBZXxLWj7Ptb+C+o6dQMViP6ANacQyvE
   olxnsZboIGxaC5OTnVcSW5TIcR41OzDgEOTnvE6KMnksEVGfgDHj92bBw
   87O+9Co06V5x38ZFDIXCKOSnv15z3B5ez07RD6C2UVfJtlRsbLhooXe/f
   W0+W36dqm9wVEzOwdBxUlDCZJj3q/rzX3qNOoOdL+qjzU3ZrC+tQtZxlc
   B2ijWL5adenKa6AejA3lWL+AOYbdXaKC0NPNy6Fk5YVVOJyxX6IUph91x
   w==;
X-CSE-ConnectionGUID: nC4T+4BxTe+9IdVsQw0mYw==
X-CSE-MsgGUID: DMD6d0fgQ1ug13KYp4Xrgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32199147"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="32199147"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 15:34:48 -0800
X-CSE-ConnectionGUID: lddjvoIvQaWdjDl1Pc+GEA==
X-CSE-MsgGUID: ayInzHYiRn6j+wr52Vw7Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94780369"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 15:34:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 15:34:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 15:34:47 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:34:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjSktJn9BZ3X/4UWvBtiAkxAoiOdyzAEDKqEVRkB22G2cljCDG0X7Bg1WFs6UaTVlWXo9XTc4M8ixJcm3izDZdoqqvlxje/SPpsKH5GBPlfhMjsKJMKYACXN9B/luZjsLWTQ3nY+SeSZC1IzwY8Lrhvc2zoB7/1Q6/JDtyar8n0hMJCox5ZKehejia6EpFlh4m78EL5Sf2c6L+g5pHXzuBUwSw7nhpvUCEz1biGCipjHgbT/Zwu2OHBHzbXGgwBErIHHt2eIQX08eufsZbNw0l7UnX6ftzj3dPIUZDMlirzWsaABARAAPLt1s0ZUp9tgHP20PwWnP7USPkjRiVJTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8Yh/e3EtJBs7mN+LhA26XrTWELj0H6lIZF2+0wAX58=;
 b=KUQ6OvlKdZmOmxX9XeAtkTzdA/2jZMHHYrNrWgytt4gGlgiXuusKYwTml1dNCcA0Ttscp17rFNZwoKAm06ZBg4uJRq5dtbNJ3I8+iLeHlyQ7OVXhkwsaNXAFmIvZVAGIoFwdIPFWPEyOkfr7s1G5+yLHZYpvcnuOClROX2wZeRjPAaPm2dDRdpWU+vZj+zO7IKQnVJE+cdiRW4pEIu7vYkV+MHPyAzekLtuN+tYz5JWDnh848Ibe4UFQIT6Z8eYdXtcVYiM9rdfnOyWezWYiGdMqdx6szNUpvPjuquTtCIXcqoG6karHfm4uK39nzXO+5wSIeR0e1WOzj6jLsC04HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 23:34:38 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 23:34:38 +0000
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
Subject: Re: [PATCH v4 14/19] fpga: dfl: store platform device id in feature
 device data
Thread-Topic: [PATCH v4 14/19] fpga: dfl: store platform device id in feature
 device data
Thread-Index: AQHbOtuZrmrMcDSvC0qmjPfPXVCk6w==
Date: Tue, 19 Nov 2024 23:34:38 +0000
Message-ID: <1bf104bd76f115f53800df15ac1691884228bf51.camel@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
	 <20241025223714.394533-15-peter.colberg@intel.com>
	 <ZztQjpI4EtmagwyT@yilunxu-OptiPlex-7050>
In-Reply-To: <ZztQjpI4EtmagwyT@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|IA1PR11MB6490:EE_
x-ms-office365-filtering-correlation-id: 7bb00ee9-75a0-445b-aa7c-08dd08f2bbd4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U3RqTzFnQTZNTWdKNUgxaU95Ly9QZ3JoeWlxTjdobm9ac3dkUGxqSnNkMFRH?=
 =?utf-8?B?TWhpK1hHVklxZjJ6VW5pTmhybjBNbTNyNysxZytXRkRkQW5RV1I4WlhtMlRD?=
 =?utf-8?B?NjhZWjJFK3NHSGFjVkMycnZzQk5Qclh3cnZjUHFNOHZBZjZIQy9JN3R1MlVO?=
 =?utf-8?B?QW5ReGxCTmlFY1JTNEdyRjZvck4yY1BaNm50WjlDNnJ6ZXRmY0RwTkFnM2Np?=
 =?utf-8?B?Sm9MMjVTZWtpQXBHM0o1UVVXdjRHTDk3SDNjLzJmNEd0VnRGMHIvSmhKa21F?=
 =?utf-8?B?aGIxQ2RNdDlSZjNmNWxMN2pLRVZkMHRnWTQ5REMyTWpSRGxLazhrNThWQW95?=
 =?utf-8?B?M1FzcklPM3BrcEZ1R3c0emtTMjNHRXlmR0FVbjJDL3U2RWRiclF2Q3ZFZkg5?=
 =?utf-8?B?Q1lrZzMwWG0zUndPenlibngwckVIc3pEeDVkTkhQa3NObkEwNjFrNnUrV1ZY?=
 =?utf-8?B?V3JrVmpUMzlGc2I5dmJETERqQUJCcXEzN0lhK0JUY2tGZGlFSkdxNUdHOCt4?=
 =?utf-8?B?Q2piV01VMnhLSTErM0NOSVNkTEE0S2p5TE9BRnhQZ1FDQ1BVVkhCZFozcEdP?=
 =?utf-8?B?UXNIYlZHWWN4VWxXenZGYVVET2hreVJGRWlST2ZuODVkZmFydTBDNGQzRGxx?=
 =?utf-8?B?VzVMQjhhSTZSejg2QndiaDJkcFFEbXYrY2o2ZU5ka0RxdUNNb0tPZFR1c1Ez?=
 =?utf-8?B?QXdKelR2T216L3NCdWZwSXBhVzVjTjdOdEduaXVramVrdURwMys3OExwaFFS?=
 =?utf-8?B?eUs4dTIvR1hJOFN6cW9VVXlBd2ZKdGMxV1E0RFljeWs0NkpqOXRaZjlpVndo?=
 =?utf-8?B?RUxRSU53YXhDT2pyY3piVUU1UWM4NDRnemNVY3NNNXdHOVdKK21vcFgxcE9K?=
 =?utf-8?B?eG1CYUoyOWMveVRDQ0tNRFgxNlNJcDFvbUpiT0xKWEJkNmEwR0kreW1zR3Rz?=
 =?utf-8?B?MElQcVFKY2oyUGxsOWxaYXRhWHN0YXdtV1lOcFVUZFh2d2doa21NckY1cGYz?=
 =?utf-8?B?ZElIVHFaYjJwclpwOHZHQ1lrVC80WmFaNHFwaWIrTHR2SFhTYyt2T2Z5Lzdy?=
 =?utf-8?B?VG9mWmJ2andMdUdDZ3pVMHFROE5hbmNSeHl6Q2I3TjB6eUUxV0w0U2YrbkxB?=
 =?utf-8?B?eEVhOWE3K2NPb0hUM3BSUTNGUm1ERVBxZ2hocXRwTHZjcGFKbHZrN2VsYVpx?=
 =?utf-8?B?Y0Ryb1lsRTA5OElweXlFVFZCQzVMY0tpMTVqSWJldXlvMXNxNEpQV0xTZEwv?=
 =?utf-8?B?bkIxYTJURmxXd3paOGl3cmw4cnVIZGM2S0l5blVmUTU3T2xRZlRCZzI3ZldL?=
 =?utf-8?B?bDlabUVBMTlrNmRSeEJXcVgwKzY0T3I1bnhkWmxXSmUreE1sTkJRMXVHdDkx?=
 =?utf-8?B?dms4aHJTOG1KQmhsdkNzRFNJbXlKbFdiNGlTQjhXazFXbGZnUlVDTlRSVjhM?=
 =?utf-8?B?ZmlsTkZkY3BmUkVKd3QzSlNQb0NiMFl1MERDc2p3cnBEanJoQ3k3NHh4SEND?=
 =?utf-8?B?bUtVMVBmVno0SzJyR0ZZZkVaR3h6TGZIeWRFS2VXWFhlbUxVbzZpZGkvR202?=
 =?utf-8?B?UzN2dnpNS3BzRDhPcUZ3UmliL3poeGh5V3JzdkZkd1JZRVZTS2hXZ0hyekJ2?=
 =?utf-8?B?TEhBWHpvd3JKYmtFUjBxZTVNK2o5R3FEcDBSeFVCdzBLcVdIT3I1blZ6djI4?=
 =?utf-8?B?TTVVMVB4VlpHOC9WSVJhZkR4SnhNYTJIdjl4RnROVkt0NmxMb205VWkvTVB6?=
 =?utf-8?B?STArcjlacU1JOHhRN1oxSHpUazRuZ2NXUnZYTlR0eGVKa004QVA3S3pJb043?=
 =?utf-8?Q?t9uBRbo1lKb4McCeyX+aZLBv6HZDTTYF09kvk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzdGOUZ0bkdqbnYwR0dmZVg5d0VFZENhMk9XMmplT2c4TGdpS0NUSDZuR2tr?=
 =?utf-8?B?N1hOUW1JVWhnbTZ4R1pDdFVhL0wvMmN2czQ1ZFFzVFZLcGhvOStQMWJQYlNr?=
 =?utf-8?B?YkhDYjQ2K0ZaUVYwN1VvYXF2K21tcnRMR2NTZ0M0ZjkyRU9rM2N3cFh3QW5U?=
 =?utf-8?B?QkUvZ1psVHhXTERwUnQzQ3BKWGprdit6clFyRGJrVXRHM1NheW5zNWlXc3ZZ?=
 =?utf-8?B?a2E3SXVMVnR3ZXlWREN1T2xENnB6RmxSUWxJYXlLUk0wSHp5ckVUdDhRM0lY?=
 =?utf-8?B?VmVKSDd5d2tUQlNGQ3hMeXpiTTJ4NTZCVWVsb0tFbmtsajIrc25Na1M1OHVo?=
 =?utf-8?B?eng4YlQrUW1LdGUzbEVMWU91ZCtpZEp6VzM2Ulk5OU1iaFY5VjFFNGhpeFNG?=
 =?utf-8?B?Sksvd0RsQmlOckErcDUwa25hc3NReDZCdEtka1FBUkZ3czhMbFVzREFwVDN4?=
 =?utf-8?B?aHN4akUvSzE1RDZTNXRvYi9xbHlRbnVCdWVSZmRXdTc3ZGoxRW1ieWxBVHRi?=
 =?utf-8?B?c1NjR01uZmdNRTBjTXc2aGxzTVJkdkRyZWNsWVdITjJKL2hzT1BYTXBqRTJh?=
 =?utf-8?B?LzNZSWppODRaZHkwUlZndmo0NzJXa3NUTzBYOGR1NWV6SVBhcEUyK09ya2Zy?=
 =?utf-8?B?UHVBT3ZQanYxbVRMUE9XVE4rSGk0WkwrQkNheGNRdmNRVlRFVTNxcU9WVzFw?=
 =?utf-8?B?VmtjcnE3QnZKTmRFRzlsRGVmQ3dnRzh0SFo5K25PSHl4OWNQalZJaW4rd20v?=
 =?utf-8?B?Q0pMbUUzUEtTRXZCeWZYRy9wSWZpUmRwRTBDUWlBWkpVNlpUTUNsaEhLaXFF?=
 =?utf-8?B?Y1NDNWUwZkxhRnlXVjY3K0pnZVBiZW1MdFFYVXNkaWZwbi9KRDlRa3B4Y3B2?=
 =?utf-8?B?b3NkaDNFMW9zNll0OGhENEtRM25WY1NQcmVscFFhbW9VMDlYR0ROMDc1eEFx?=
 =?utf-8?B?Y3l0SHprZVZsSXNTcjFOOXZCck1EaHUzZHh3MTFHY0RhaEhybzFvNnVTZDR2?=
 =?utf-8?B?L3ZhajA4OW5RcG1XckVYUEZQSTJwU1pObmpFanNzOVBVS211MEd1QUZQenNu?=
 =?utf-8?B?SmhQZHJrQVBuQnFBOU4waUw4ZUlkb0V3UW9xVFQ5UFFqdGR2M2dBSGMrSUpC?=
 =?utf-8?B?VHdBampMTkxhRHFkTDI2RUprMFV5MTNoWnhad1RWZEdNMjFYdkVCWGlTZTdI?=
 =?utf-8?B?MEpiQnBWaFdZZHFkanpCc0RNNndtRkRFNFVvekQ0aXd0SmF0cy81alN2cHNx?=
 =?utf-8?B?ek85VWdjRTN3N1NLbGJXb2NzeXJsakw4UkUvS3lWY21UVWJBb3oyTXU1UzNH?=
 =?utf-8?B?SWo1dDlUajhNUzhBbVJKeTg2ejRGZ215YnF4V2pEczBMUnRLWlpyeWJ2LzRh?=
 =?utf-8?B?Ni9aelM2bzI3Zm14aHRpY2Q1TVZORUN4MDRIcGQyd3hQeWtTNmxxOGcxTGdC?=
 =?utf-8?B?V1FnRzlaSS9mQ3h5NG4wM3UzeEhXRU1mNmRMRjNSZ3pqdVdmcUw3Z052Mm40?=
 =?utf-8?B?L0ZCa0IrTGx4Y01XWmxQYlp6Rlp6M3dnQ3Naek15VEVXa1pHbXdjVW4xN3dm?=
 =?utf-8?B?ZHB6YXFCa3I4ZzE5Rk1vczJIKzBreERjMkRFbk9xMXRUazYrQmxkOGNpcHBG?=
 =?utf-8?B?TkNsVzBHSXpvWW5TM2tsUGl0Z0hGZHFZeDg1M2FqUmVpVWdHRmZ2YWhzWExC?=
 =?utf-8?B?N0VBeFVqWTFsa09nc3ExcklDdEpSMEdiK0xnQ1QyUHFSMWlhamttTHk0dmlm?=
 =?utf-8?B?TmVRVUYyVU9FZjQ0VmtxYXltWmFCcjN6WGtRMWYyT2JubnE0VGc4VUZDN2Fj?=
 =?utf-8?B?SlgzbDBCMG41eE5DbjBzTWF5M0NmNUt2aCtvdVhCZ0NaQXVRZG9wMlJONHR6?=
 =?utf-8?B?MWZLVitjeCtZdnY0c2Y2RFp3dXZ0SDlvNkp3NVpXY3dKbUx0c1BKTEF4N2s2?=
 =?utf-8?B?RU13dDYyOTRCQnBra3IwN0hMVVhQMG9CeW9DeWtYOXZsVEpYL1hibDRSR2RQ?=
 =?utf-8?B?amtJbkJVWEl3UTVwQ1M5YmNDODRrbjZLWE1BUm9zT3BUL29yS05GSk9rTTh2?=
 =?utf-8?B?SFJRMTN0cE5uVXhIK293RmVEcG91Y2oxcDRmVG80cGNVUUxVMEVLZklTZmpx?=
 =?utf-8?B?MXE2VjlSSjhwR3dMZUtTbkpLaHd5THZ4THV5WnlNVDNhR0dtcURIN3gweGpw?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93C283335E7CA44CA6C54A8B53895076@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb00ee9-75a0-445b-aa7c-08dd08f2bbd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 23:34:38.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YH0hN5XKZMTUZczSUiNmEgw1lKXa+Nc6iBMhpZb3XJZTl4mJpk4yEWs1gQR/GQvoZHvqddeNxA3xZO8hdkPCOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTE4IGF0IDIyOjM0ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBA
QCAtMTY1OCw3ICsxNjYwLDYgQEAgdm9pZCBkZmxfZnBnYV9mZWF0dXJlX2RldnNfcmVtb3ZlKHN0
cnVjdCBkZmxfZnBnYV9jZGV2ICpjZGV2KQ0KPiA+IMKgDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4g
wqAJCS8qIHJlbW92ZSByZWxlYXNlZCBwb3J0cyAqLw0KPiA+IMKgCQlpZiAoIWRldmljZV9pc19y
ZWdpc3RlcmVkKCZwb3J0X2Rldi0+ZGV2KSkgew0KPiA+IC0JCQlkZmxfaWRfZnJlZShmZGF0YS0+
dHlwZSwgcG9ydF9kZXYtPmlkKTsNCj4gDQo+IEFsc28gcmVtb3ZlIHRoZSBicmFjZXMuDQoNClRo
YW5rcywgdGhpcyBoYXMgYmVlbiByZXNvbHZlZCBpbiBbUEFUQ0ggdjUgMTQvMThdLg0KDQpQZXRl
cg0KDQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQo+IA0KPiA+IMKgCQkJcGxhdGZvcm1fZGV2aWNl
X3B1dChwb3J0X2Rldik7DQo+ID4gwqAJCX0NCg0K

