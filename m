Return-Path: <linux-fpga+bounces-913-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FB9B12EA
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93436283B65
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7FB213128;
	Fri, 25 Oct 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mArE1TmI"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8599213121;
	Fri, 25 Oct 2024 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895997; cv=fail; b=d0A+F0gby1ct6Zv3L9buxUOV0O0OELBAMlV5xDOiTJ9N5ghJoJw2QILQoa+uxom1OXSb847Qr3O4mBLxLxCbhTZgfux/io3WcG2sNJhUhQ9NjsrOEDqEblK5D/TIERmF3VkNaqXWhxKqr5WFkdjFHTS25y6BfpPNtA4Z5YFImlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895997; c=relaxed/simple;
	bh=322mgrmuCnf/ayctfZGniAeGdYsOEtG8xRRGRdLd6Lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XaJOvh+okF+UrfLSIrOGJyK6wfvXA9J33x81g6BngnYY7ehPPiiofRU53AlHzw/WCBM6idR5ZEult+S1SiC9Xun1FgFj+o66N8zMKxqQ1kyfeMt3H0Xv7JzmPjm+rKdElPZzRsn5sWNZxLDJNDKnpH1WA9QmOj9b8OP0+lqTat8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mArE1TmI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895996; x=1761431996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=322mgrmuCnf/ayctfZGniAeGdYsOEtG8xRRGRdLd6Lc=;
  b=mArE1TmIjxQraA2Rs5FeKW/z7RtsRQUaYa0TdwrA8gKh5GkTh+fMXolA
   mObnXJLf5xgTR6DOnRx07Ig+joC9iw4WVoi4+zJx9OIXeVedEoPDfITHb
   5KF19afL1woSMhWv/aS8dXrT06r2Ktjx3NDdcSbws1uqyJLyXEYDiynvf
   mwaY1FWFZ3Sm8FEzsK33by5oxcWtu4cfeRjMikgaSoGzYhkuTWdg1BEnP
   RMnRbfdFtkR+jBi5To1NNuUXIpwfU0XWFF4IBNUjV9yjI0DeWq16g0dGC
   +30RXuBVG2x9dTf1FIvc9w7QDlsoyk/0F85gABySQRRoHcruglBHS93uP
   A==;
X-CSE-ConnectionGUID: bjtxPvR2TUCxjrSUUa9l5Q==
X-CSE-MsgGUID: S8tLWoacTMeHUPd81DxM7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="32437782"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="32437782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:39:55 -0700
X-CSE-ConnectionGUID: NoLpU/b6Q0SclforuLdzrw==
X-CSE-MsgGUID: uT8a9aomQwKq1FM6N/FY/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="86165063"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 15:39:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:39:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 15:39:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 15:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bag7M/4b4F2nUxd8CdoraABUfdaSOWBqTTRVjFFnlM8uP2IRJVxz5tYYmHxHYem8dcFN4xMnwiYfpIPk3DBPMkU4SN3rI40ppetx+JsPKqUkjvKLx3jHqVz28wN2d9t3Y+OK8CeavCmcwzQtlfR6T/SauyntmkCz8Nmk9PP8fFwua/AxzYuyUhawsGt+6ulfFOcPFad+SuHgjvVYPYBlX8edjMqgvvsAOkOVR3EyIrJqjnBocUARApqvfBA9IkW2zF2pR/5BgC12Q9QJFbPZ5J98ZeFsXiYY/+hx8NLv/BfFQaNDAvHTvg3D6dBif5uj8II853EOGVHP7MJ0kJu6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=322mgrmuCnf/ayctfZGniAeGdYsOEtG8xRRGRdLd6Lc=;
 b=pirCZ5bUeOCubuEapc7dhZpzggA/559lnNaFpq0o0lJTOe8iQ908W33OoWKf4rcrCaR7YbWzBoUL2Q9MlR3NiUn/M9VECSoTGil4GOiYA10kZY2aBpsAzNGdK5MuVsShbupvFqidD7tgkJDFLBIZBltVkG1jGnaOcRhR3aQJyf/UnXsttG9EBd29q83OYc2a45ajLuQL4UJKidky1UO0NfCnggZQ6aeWCIOcF8pE6GQIazREaKyKCRGogtrg6RB4FfF5s3+y1jsxUkIwEx5fHG1meoKv1VU/QpqpWGVgRhnbsWe2dWe3aTh/fZ6ud7xbwBomBoxmqdDOxYRTyAMGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 22:39:51 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 22:39:51 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 2/9] fpga: dfl: omit unneeded null pointer check from
 {afu,fme}_open()
Thread-Topic: [PATCH v3 2/9] fpga: dfl: omit unneeded null pointer check from
 {afu,fme}_open()
Thread-Index: AQHbJy7N4meLN5EyiE+qoS7kJ6JSTQ==
Date: Fri, 25 Oct 2024 22:39:50 +0000
Message-ID: <9377619cb46809575611951b9e77a4d8b2bbdf3d.camel@intel.com>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
	 <20240919203430.1278067-3-peter.colberg@intel.com>
	 <ZvJb8HhT+5ArWDsL@yilunxu-OptiPlex-7050>
In-Reply-To: <ZvJb8HhT+5ArWDsL@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SA3PR11MB7463:EE_
x-ms-office365-filtering-correlation-id: 88c66db9-81fd-4461-a8b1-08dcf545f01d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SlJWeG5VNkhoQ0M0STNZWVkwdG5xdTBJdkoxRTFBK3lxNGMzVlNDd29zcWww?=
 =?utf-8?B?K0VJeHhxVGZUTzI0aVFwSXdzMXZnZW1ucGlZaUpvcVFOc05IYUt5NzZUb0FY?=
 =?utf-8?B?N01DRVV6MGREeW52YXY0RDFSRVRpRnVkKzFMcEI5dVU5ejZGSDVxMnc5TWVo?=
 =?utf-8?B?VmFBZEJIeTYvSVgxNFZJVUgrSDdRSnhiQWpvUGRGR1I5SXkwZmJseHBzUG1I?=
 =?utf-8?B?c2RLSllJVmloMnU3K1ZXcXBoY1V0S3BmQk9HWmtuQTY2TjJKS2gyMTYwYVhU?=
 =?utf-8?B?aDA1b1NucUh6akZ4THZuSktNN3Irc3ZZSktodFlySjIvc2ViTzVRREJPZk81?=
 =?utf-8?B?WUhMVUFrbzh0QnFKU3V4NnByMkMwbkF3eVBqT2I3QjBxM1EyNFVuamdpY0w0?=
 =?utf-8?B?OFhtdm9rVFBkamNIZVdyVFFFaGNSci9PaUpPTlFENkNhTnhKZGNjL2pXZ3ZN?=
 =?utf-8?B?N3BCckRnQlNFMUl0MmNtYWREaUVNRXVhcW5CdnZTM1phZkFZc2srdndHckcz?=
 =?utf-8?B?MnZERnpNdEhoUGJSbGtQbVVxd3NvSUtFVGo2bXBnTlpBQmthalkrNGxUcjJS?=
 =?utf-8?B?TW9hZG5wdkE5VXVmMENUWDFQKzZXWFc2NVIwWGplN3l0N2h2Tkwxd3VDek0v?=
 =?utf-8?B?cDBkVGg1Z1RnSnlzK25iVEFsdCtteEtCVG94WEs1YVNBNjZPdXduRHA5cVl1?=
 =?utf-8?B?bldEQWl0M3U2cWRWd0VZYUhqUXV1b25zKzc0QXJHcEkyWGVrVGlNV3AxWFVL?=
 =?utf-8?B?QWlHN0JmZTBpVzZ0bTUxUi9sU1RCT0UvS1ZqbVJ5WVZsSTlTVnRZR0R1V294?=
 =?utf-8?B?T1RvVDBFYnlJU08vNGNsUEtGN0h6eHQvOWNFSmNIczR6cHR3b3Zwa3dHQTdL?=
 =?utf-8?B?bzJiUEx6QUdCWlRFMlkxcDdrNlNhbmFBREdCNzRhMU1OK1hNQU5veTBacXZL?=
 =?utf-8?B?Uk1NUFJoQ3QzcS9KSElMbDI2anNnTVpUSjJhY2FNWjdOM09hbHVqNzdFZmpO?=
 =?utf-8?B?S1lMV1pEQnN0UGdzQ2ppcjZaVVgrVTFGZTVTU0U4UnpJbVBJcXY1dzVjV3dY?=
 =?utf-8?B?WG1XUWhVQTBJcWNIKzRDQWd0U05uNHJ0VGNzai8xQ01VeDZrN1h1bllNNHNF?=
 =?utf-8?B?MzVtbzcwaVl2Z1g2WEVtRWQ2QTNVQTNkYitHV1N5Uno5NUNvM0tGcmhXV2Uv?=
 =?utf-8?B?VXFQNWlXVzNjcDN0L01XZmtheE4raGpJcHNXbEFxK1ZldlovUGVGZWV3TzZS?=
 =?utf-8?B?Tm5JaGFlL3AvY0VGNkllS1k0ZUY4dnFvRnlsVG5nN3R1SjFZZnlIMXlidlRF?=
 =?utf-8?B?VS9wOUhjRHpXejV3eFhKZzcwbVlKTlJ2MjNkSVJGQ3NvU3Nld2IwbHJUUXdS?=
 =?utf-8?B?L3dvaDZFeWtoRVp3MlV6QXdTOWxnd0lsZFh4QkdZRS9FUjA3dllKN0pKT1hC?=
 =?utf-8?B?MnBXdFNUVHppeDgyZ3piM2lGaGRCODN6WHpTTXZPMlhVRTg5VTNRT1F1Z2Vi?=
 =?utf-8?B?bFdqOTVEd3ZBbXE4aWttczhBdFVRaFA0WG1OekhlQklYMG1mWU0xTVNYZkZM?=
 =?utf-8?B?T0pVemY4dVNHUDBZNXhHWFFSdlg1YXlZMFNJN0tveUJqbjVkQS84OEJTNnZn?=
 =?utf-8?B?VklKb3hvRDg1dDBqTG5MS0ZKRFlDS1JhcTVTQTZYcHI4OGN1d1I0dzU1SFV6?=
 =?utf-8?B?RUFsMWtpdmFVL2N2YU0xVW5jcHZObmh5WUVDUkdLQzJ2RkwwT3VCdlAzc2JD?=
 =?utf-8?B?U3J2Y0cwUng3eUUyd0VwWkRjdTJUVXBKakNlYTRhR29YdnZuTnk1VmU2NnhD?=
 =?utf-8?Q?gxy9RP5ULrISvBjwWqzXgNxTLNJ1ip6e2E1gs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlFHdS84VEJUOTdwOWh2clArRDB6MjdyK1o0VTJncnNoRytmT3ozQzdEMXU0?=
 =?utf-8?B?aEdCZjhvdFRrT1l2VzJrYzZIYmNaaVc3Z3ptbEZoNjlxK3hpRlJHUXlzQXBP?=
 =?utf-8?B?Z3NWYytvY0hNeHZPSXp5Y2JTclF0MjEyNFlianplRndCTzJZTmdXN3l0aWcr?=
 =?utf-8?B?UXBSa3k4a0tueURUVldpUXliZCtaU0QvZVkweUVvRjV1Z21RUVlhZGh5S2F1?=
 =?utf-8?B?VW9mR1F1RmZDU202R3JZaXhpN0Nlc3hoN25CY2FNaWg2R3dQSnJqSWlDSENj?=
 =?utf-8?B?ZFNzMHozbHNDWG9IL3Rha3VDOXFtN3Y0czlKaXpSUFJLMGdnR3pOYW9HMFRw?=
 =?utf-8?B?bGtkdEkwSjlzQkpWZlVlUHNtdk9sOGVBR0ExbzVGZm1qOE5LRmpPeUZyOXIv?=
 =?utf-8?B?WFUxTC94emIwbFFsRm0zRmhRUGlOMS85MTR2aUpyeVIrYmhWeHVYSWV5RFc1?=
 =?utf-8?B?dGM0ZHBwOXVsQ0gyUFJNbTZvY1Q3bVRSalliT3c2ZE9VbG5WQnNWUnVYcHor?=
 =?utf-8?B?dzlBZ1F2R2svd0RaZUY1QzIyQWdKL04vT1hFMDFSUncwcjNXQi84dk91Y2dH?=
 =?utf-8?B?bjhteTdTNzh2NlBNazFCQjdtWHNQYyt0aG5zSHBWL1RHNUFudFp1WVhTWDRJ?=
 =?utf-8?B?M0FhYzYvL2ZEZjNTcXJnVTA2Tzh4T1NNT2J4WVV2UkduVUg1MHBLbldVRGNi?=
 =?utf-8?B?RHk2Y2JxdEpGaGNxNmIxK0QrK2VvNGlmZno5VWZuQnNZNjB2alFRby94YlM0?=
 =?utf-8?B?ZkJCY0MwdmN6MjczOEJFYWxJdUJRNUhmcFNRdy9VaXlOQ3JyUERIOXlJVVpq?=
 =?utf-8?B?V0xUcExTclVBeHJpMDN5M05ESU9mSUs5Q2hhVmhselJ2NmxmTW5zQ0lVQzBZ?=
 =?utf-8?B?eU5lMzk5cGowdkRrWjFMTGVUaWRUdCtFTEFOdTBSWGlHYUk3QjRnbW5CcnJy?=
 =?utf-8?B?S2ZROXZnaWpra3M1RW4rVnVRck5LUk9zeExuZXVGVnhDZkxyci84aWtUSnBF?=
 =?utf-8?B?ZlBtNEhkbmRvV01lWnVwdEROY0pjcVVWb2R2cHZxbFhFSjBIVWlRMnVTTTJW?=
 =?utf-8?B?OVY0VDRIUkpXQVIvTUpmZno3ckovM3cxUWlRellLM0RRNDd4MnA5bXFZbzVV?=
 =?utf-8?B?YkVNN29BUGZTb1JpWmxrRDhxY3l3bnlRSm91RzZ2V2JaRnUzOEk5UmFxdWFN?=
 =?utf-8?B?Ui9pcTAwdmFoSS9tc3kxWit5NWlzM2xNcVB0ZkJMOVdGOWxYeDRpdzhRZnc4?=
 =?utf-8?B?a0xJZmVDTy9MSzFGV2dnWk5CVlZ3NUdxbVZGcTdnY2FNYjdYKytmR3dDYmxH?=
 =?utf-8?B?MzZGZGRmYUxnZHZRdXRZdFRFdFVuQytsUG00ckxMRU42b1h2OW5Ua1MrUGVK?=
 =?utf-8?B?YjlZUGRpUUJ1aFRvTzcyUmNDWlo3VlVBZnFFWUl3S3h4RVp5UTZ4akozSVJS?=
 =?utf-8?B?ZU1jWEdxdHlSUm5HOGVEb0JrcFBFSVpKakpBVnd1OFhPdjdxNlpqMk5sMExL?=
 =?utf-8?B?QjNnTDAzMVpaZ2dCRld6UEhkb1FHU2NzeGs4R3RmL1JMRUl1Mk4rdFphV1pD?=
 =?utf-8?B?TWsyTjRaM2Y3czBlOGJSaHdJOWd6NDVVODRSY3FZNUlEQ0ZMTDltbW5TeUN0?=
 =?utf-8?B?ZExOUjhIMjBEUEpESFJHd2xMY0NaejFmV2RpRE5iNWlFQ0l1MERIRHJFN2dw?=
 =?utf-8?B?UjZmMXBUNHQ3TXh1SGkwbGZ3VThRdmZtUHVtRFp2OFpSZjR5WkQ4UE9VcTFV?=
 =?utf-8?B?K2pFSDhPWnhmbXVMaFBHd3JzNnFScHpnQ2NvS01WVVFqb3JvMXhrdTFjTThz?=
 =?utf-8?B?a3RlT2RrNUxBSmtsOFRpbXQvWlRjRmZNUVFla2V3T0lpUGtXbVkzVUFTOHhV?=
 =?utf-8?B?N1NvdWtsUmd2bW1UbHlKVUp5U1N2MEhZQkpCQzlTUndhQlBYZTR1MnhFTHR4?=
 =?utf-8?B?clBmVytTcGVGelBOTE00cUJKNW5sNm53R3J0cFl6MnA5SSt3M3RxTmp6ZlI0?=
 =?utf-8?B?dVBhdlNOQVNjQUtSY29FQW8rZFAvZlpmY0lYTnlrcFN0NElGYkZQVXdPdjlR?=
 =?utf-8?B?Ry9sdDRqK1NPMTJhQWtKcUNXalNKV2JIaWVjalVWMUk1RFcvSEZxM05STDRM?=
 =?utf-8?B?ZTdtQkQyOFpJaExOOW1sNllHb3lTNjk2TFpiYS9NRVk5cDVURFZsWUV2T2pm?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CE86B1327610042A01CDBD464C89E93@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c66db9-81fd-4461-a8b1-08dcf545f01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 22:39:50.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdnMP10J/fhPnM2umqh944xddnuXveC1vDshjGs1yE4k3uE+PP8dXQIOhOhBXfXzcQ9z+R35uVGod700jChh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTI0IGF0IDE0OjI4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBTZXAgMTksIDIwMjQgYXQgMDQ6MzQ6MjNQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBUaGUgZmVhdHVyZSBwbGF0Zm9ybSBkZXZpY2UgaXMgZ3VhcmFudGVlZCB0byBoYXZl
IGFuIGFzc29jaWF0ZWQgcGxhdGZvcm0NCj4gPiBkYXRhLiBSZWZhY3RvciBkZmxfZnBnYV9pbm9k
ZV90b19mZWF0dXJlX2Rldl9kYXRhKCkgdG8gZGlyZWN0bHkgcmV0dXJuDQo+ID4gdGhlIHBsYXRm
b3JtIGRhdGEgYW5kIHJldHJpZXZlIHRoZSBkZXZpY2UgZnJvbSB0aGUgZGF0YS4NCj4gDQo+IFRo
ZSBjb2RlIGlzIGdvb2QuIEJ1dCBwbGVhc2UgZWxhYm9yYXRlIG9uIHRoZSBwdXJwb3NlIG9mIHRo
ZXNlDQo+IGludGVybWVkaWF0ZSBjaGFuZ2UuDQo+IA0KPiBUaGFua3MsDQo+IFlpbHVuDQoNClRo
aXMgaGFzIGJlZW4gZG9uZSBpbiB0aGUgcmV2aXNlZCBwYXRjaCAiZnBnYTogZGZsOiByZXR1cm4g
cGxhdGZvcm0NCmRhdGEgZnJvbSBkZmxfZnBnYV9pbm9kZV90b19mZWF0dXJlX2Rldl9kYXRhKCki
Lg0KDQpUaGFua3MsDQpQZXRlcg0K

