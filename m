Return-Path: <linux-fpga+bounces-1362-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9DBB82DB3
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Sep 2025 06:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59111C200CE
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Sep 2025 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1479723D7C2;
	Thu, 18 Sep 2025 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bC91il4x"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF523D7F4
	for <linux-fpga@vger.kernel.org>; Thu, 18 Sep 2025 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168562; cv=fail; b=vAXA6GiCsYSoNOSo6NvFi1uNsmsNMEkuQAzJF/Pf3OSUw7El5HYBTZgNkgjrBLDNBFE2+PWVlqlyFOhuh7utoU1seWRntGsSIFJEJX9+kDcokKYH9CT3S9whuPHppR153g9Nh2CGYp/Nu1t/3GCAobeCfagoiYzO5JT0GO4tDjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168562; c=relaxed/simple;
	bh=NpfDV5Y7mhbIewXBFxDQWpxzjTR7tb9lWV5cSazKcgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyQX1usyBSi4kYXz+xTZZ87UfWIPsrCA3vbBeGqCSbpBnqL9dLlnIbOA0BD8ufy9wDJ/v4NDsaBvKqyror4ZP13nUviforckXD4k32pkqoewOwYV/V7/a257ifE2eKpYD7+ouUF8wcf/Zwf/dqbakBx/1IxzloKQsRKc/hcgGjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bC91il4x; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758168560; x=1789704560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NpfDV5Y7mhbIewXBFxDQWpxzjTR7tb9lWV5cSazKcgk=;
  b=bC91il4xtlDa5Oue3sOFMwhSPLEGUcykP0afY5CFSvfu23ni0cqnSM0l
   cUoutmnkGzHOI90oNulOKrZfFeod106t6XoFnf48ut7LRg9d1t6PmMXER
   0Kp63UBIDSoRjIHunumJLU1ZwDp0j5TN3SBCK6/pOKFR5YixFc29Svds0
   NaVJX+q80KHzDDHNe+kT3Xgcwbe3cLJzmzLfQmXR8reyodsGq1pA1pTVP
   UoBYeiWrviOTDhjHHOixcNKLiqmc2K2spNZ7PyoVZa4MjFpsiFTi4HPo1
   5e7HBCrJOM5EcYZiOJJJMm6c4aWY6ZS0eHsmfaDMg8PpQPCCa5QH2ziId
   Q==;
X-CSE-ConnectionGUID: Rg/86I0mTuqrLF9Cd3HBYw==
X-CSE-MsgGUID: wMqqJFpUQyypcD7f5jd/cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60419272"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60419272"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:09:19 -0700
X-CSE-ConnectionGUID: /wGdxwWdSrejx7OuYWrzIg==
X-CSE-MsgGUID: mCOZYkwgR62Hz/ZN0/2B7g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:09:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 21:09:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 21:09:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 21:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wr9WmUvVL8Ial3lkCyUDJOPDQl3kXBGyRbpn71LMBECmSs4hcTEjkG/OQdkFWPvMkZeW5SeS7KcFe0fRPtWwaL6XUczexQzdwmKn5uZAgep7fd4qsWt49rIXBmpUJQkqoxolfR2+tH6Y0WNkNz/8iRk7yj7HXXAEGD1yRf4IefXxcBvyHfLSumOTi+j6o+AojxMxIjNWO5JI+r0YqCjC2AID2NXx7lcVadT905gyA7/G4iZ229oUpmPTLG/Z8HNWluyiUe1bPe99NneUE7PrUeyq8sUPqbFpH1qEpfWSL0MV9ubfyZtAmLvYiTSxybnI9+TMlkFhEp930YidIi8nGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fryYSwZYkE4Wt5koU/oDZOSXVjNj+KeamRJ9tWTCpsw=;
 b=iFzMI+oBRAhOU+QCgbLYyNj1jKG8sWTSp+rrMqqxYkhmh8ljsKF1Wi/PC/iVdii8lq7zfD+us+0aVuRXKmEwy4FPXnoCOEU9zvzbAy8sfI12fp6/qqrJOkDVkRcNA6E+tw0264LlP26eI6vK7y0AEPXO9/rOehvBxntCBrmgswQlyNxjsWABdTYnDQlFihzpgiyDxTenIzy+gKchHDirdkEKvy6VyvxWPfQdRSIIQtRqbt9UkBQTny8GgCsfdsv0gJbjxhNHKX6JWK7TxO51QKw462jwsiCtSP8P0csEZHIXQw0LMPX2xigBtGjekgc/ZCOgLwPQby+cfDaKYMmsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5628.namprd11.prod.outlook.com (2603:10b6:510:d4::22)
 by IA3PR11MB9111.namprd11.prod.outlook.com (2603:10b6:208:57d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 18 Sep
 2025 04:09:15 +0000
Received: from PH0PR11MB5628.namprd11.prod.outlook.com
 ([fe80::4800:95b8:1ed0:64c6]) by PH0PR11MB5628.namprd11.prod.outlook.com
 ([fe80::4800:95b8:1ed0:64c6%5]) with mapi id 15.20.9094.021; Thu, 18 Sep 2025
 04:09:14 +0000
From: "Xu, Yilun" <yilun.xu@intel.com>
To: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
CC: "Gerlach, Matthew" <matthew.gerlach@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: FW: [PATCH] MAINTAINERS: change maintainer for Intel MAX10 BMC secure
 updates
Thread-Topic: [PATCH] MAINTAINERS: change maintainer for Intel MAX10 BMC
 secure updates
Thread-Index: AQHcJyHfHdrEHu/YbUe+hikLmgfpFLSYVRSw
Date: Thu, 18 Sep 2025 04:09:14 +0000
Message-ID: <PH0PR11MB562884BA1B9C6215B3B5BD658B16A@PH0PR11MB5628.namprd11.prod.outlook.com>
References: <20250916155152.411121-1-matthew.gerlach@altera.com>
In-Reply-To: <20250916155152.411121-1-matthew.gerlach@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5628:EE_|IA3PR11MB9111:EE_
x-ms-office365-filtering-correlation-id: 80e19cfc-a558-4c80-05ee-08ddf669210d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?WrtlAVopQZaVhkbjMsUZMvkAKWwVlzbvKRa8fNWYmMGwt6KjNTGqYY6jAan9?=
 =?us-ascii?Q?c0XZDFvcvYMKJAuN3RiEHLjT7zv5bml3BuNdj1VMwyieMUWss8lk0iYgblo7?=
 =?us-ascii?Q?uY3feL+9q4HQbP3dFF73NtMD52n3JW0Hk1WJtc0yQgOxhYsW2RzXa3km400q?=
 =?us-ascii?Q?JxDN/tAhu1ooNn3F8LE4Pp59PN/IiuttjPjdfhO+dBJTEmC93GZQk7PAjMmC?=
 =?us-ascii?Q?is3pZpU/ckIUqTKzL1C12RYotIMttKJdXLwlltmVBHTh5gInf33I9igPjAe7?=
 =?us-ascii?Q?yLemmke1jQMDWphTQQF4HcK+HF4kUypmeyRZmBnkn+NA69HxrffzAXQvCYj5?=
 =?us-ascii?Q?QVWTWzY/jXuLyxMpDhgGLvfYptnEhRg8SIKLGUOOTrfrbyC+ZRcr8XnS0bkP?=
 =?us-ascii?Q?QH1nqVE2icLlVpFEEg7DiLNHh0B1JIEJPaW6/h0JYYaBALe5LaE7LiAPUj3m?=
 =?us-ascii?Q?6aliz04MDVkNL1LIJBw+sX03z1zRIoPpEIdk4DqHE7ALVkoyWZccs+R3ig7j?=
 =?us-ascii?Q?U3z9eOnDtqV/MndNSYqdCLuqdMm2ff4pvXzMrhUwL2YZSdE6Lj72BM99oZP7?=
 =?us-ascii?Q?YJb5+Iyg6E+FzSBLIqcCv9SQ5ysxP4KmR7Y4Lu86A1gaIzFcqrgaM+B/KMuK?=
 =?us-ascii?Q?AjGq1932X2oLjIBbnGo2JdOa6O9fH4APjSoJr7Fm/pyusb8rikUJe8dkvICS?=
 =?us-ascii?Q?GNAaNnDOt2ASnLc6smIgLLf+VixZN3/tyRDebsDfAOuA3RGhJD3EqBc8ID0K?=
 =?us-ascii?Q?nTed58smiLsRlHbWKeHfxSHhBDLQNFecz34S11hFHIQ4IWF6152SiUKcTiYg?=
 =?us-ascii?Q?WkGFxHeyAgt/yU/u2/9BLJquaoJ26RM+tFQ+G802Rqm7gW+LlvKu4l+1ow3q?=
 =?us-ascii?Q?ULqUfIsaQWTuaOBoGtOHCCo/M4CZpY2/bcD7Z1oxEdlFLpjgOjNoh6xFTYw2?=
 =?us-ascii?Q?TjzWnNK2c86eJHcq7/6mTfNqpsq10uKkRH/d1+ytuKCr4Wyf40jGt4GKF3Tr?=
 =?us-ascii?Q?ABAXf3SN0GpYylngednMVd49Oe6BoF4zU4O0GkEjj8zKyyexyfFxWCBC+4hx?=
 =?us-ascii?Q?U03rDY+EV9Kh33JILpC8ynMWCwXBltGuH3xD4PW2vN9qOAqRvusC1MhEJBty?=
 =?us-ascii?Q?5VtN1eW8p9ZgX/GFxeNDMwS/4gfOi+fRB6UvpVk4l8NmUq+T6rLgIKGbtFNT?=
 =?us-ascii?Q?22ipaSknGLTb5RObv4Vs9p3kboGy62XmrZMOkiChmS2iMwaf8jBhS2w+0SsY?=
 =?us-ascii?Q?hovhnZ7nS+wr7dxkTky+dspYaYC42kulk7QhfmliOPDnuYdKda5xn9T3UeFD?=
 =?us-ascii?Q?+GqjELRjWKP4wYHEODxQpkQIbxgoc9DHL+xcXQ3Xq7P9akdZ+j8H2vJpNcS8?=
 =?us-ascii?Q?9ve3RHfdruovWV9SZoN2gN9IMqPwAsFlU93menl/oa9UZ1zeqhfI8zhahhbV?=
 =?us-ascii?Q?LiYXQz7dOhpNrW0EbYWrsGHVIuDwJn3Kmmts9xOEGEicB8P8BIf6didGLU6e?=
 =?us-ascii?Q?D2/aZIW9QG5chQU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5628.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9PDatp8+Lqcqos+cWL4DS5jBX4y50lXkrD9xIQeRzVdorYkQebCTKhd/LYra?=
 =?us-ascii?Q?4yteQUQpazD8z8NhqsBbyeNXG3MRqUOvjXJXhFbn4vKwt9yj+W4jZxQ09H1y?=
 =?us-ascii?Q?CSkhRbY6M6hmLZxIPmh9DjuoVhuNsJSItpMVkAci6wj16V/AuY47aQ5I/DFV?=
 =?us-ascii?Q?8dKOGDMnve2OZ99bCkysOOqXdn3pqrH2R9ZkRJn0bTsT5llepgKs6dN9Fe3Q?=
 =?us-ascii?Q?TjRr3YCCE0id3Stnh9BYL/f4gfj9T0fQe7R6UJDxU4fhyiQr/WHtw+BDW6RU?=
 =?us-ascii?Q?h8OSZUChaebMpC1d9/cD2IKEY6wp5m3dhR5yKQ05IjIXkLjANmm6AuO4fbNx?=
 =?us-ascii?Q?ocMwzkZlKJVBpYqqDGyWhiAXmXKxkloSSSy8/OQ2/hh1qVuiXDQV/5eoiQRb?=
 =?us-ascii?Q?hJ/EcPLmVLA3n9yFzWfa+X30rMMDC5S3SsqtwQXScGk2EChZVDNo/iU1MQYC?=
 =?us-ascii?Q?g0n2IzUf9CI3opCQfc93ccvd6I/IJ/4kYfdWyoyI/xGstSt/tiOMnECsG9uT?=
 =?us-ascii?Q?25l2m+PBgBnA0nEgOKaed8yKVJyUw+qfJ87l9y2Qcv7V1QYrtIj68lz0LWRN?=
 =?us-ascii?Q?ho5AWoKZmO4ORou3kK2khrh0z3m7JaxHW+XFHbf/jH8TWyc8WpV/iE3ldgza?=
 =?us-ascii?Q?H/wVZQBz5PTdAXDOvn7zP0uuTf4OY6bqUWo5x3X4kaOz4OhqfC20l7nLU0Pb?=
 =?us-ascii?Q?3FwkwgDWn+QwWUp7j16FhhsCnwOrsZLDOF2DzFj6mWTaveAYNOd7OoQrzumf?=
 =?us-ascii?Q?9D2p1p3FxzRrgIas5CBRXo9y6+02Y9+8OOseEFwjVQKJCsGmd+CGMhMHP0Rs?=
 =?us-ascii?Q?V8SHtM/pvi4VDUowVqlgum2mXv8fPsTcEJUTzjt344da48p2jnKKjFvnT14a?=
 =?us-ascii?Q?f7DSTNV2vXYZrtv8ZWNTsT8IkIcElzNGlEU3gIwuhfxjmWq0Zpu1TLXuGXQJ?=
 =?us-ascii?Q?1M/ZVkzhPIyIavrDlYD+Ior6YwUssqdH5ihtfaXKCgsXdTPKwkWy+twPKF4u?=
 =?us-ascii?Q?Rh/eWOpPlCP7TkEljbM876B9udMU+aypKGSjG1SNfvcysDPDNrXi/Lfr7gdU?=
 =?us-ascii?Q?bisjjKBW7/S8bf6DyqpCe2ltmlTfeLAG3VU5n0IQFGttg5o3qxKJxsaYFNOK?=
 =?us-ascii?Q?1OUPeRZHqhIGjeSghI3lEilCmn4jZFif8lkH/5a8G4VRq5o9cfBgEHbMZUmg?=
 =?us-ascii?Q?0hGdOPWBz3TCnttHJn4FzzWePLT/L6m0ikjkeZ0T3MccTQDmZzUT+RveT4MO?=
 =?us-ascii?Q?SHRT5ddtSvhOhGmmNqN/6o0HKvNluLVpknmPI7Y5OwVQaaEP70kbrGYGmyK9?=
 =?us-ascii?Q?ntArNYh5/1y9VnuRffY4zO58fklBEhSEs6NSBjjl3hZQ0KiYWSfenHV2h+VH?=
 =?us-ascii?Q?811XEqujnn3FE7+S5g6FariqIqkEN4bIbNq2LlBkd5XWjeT7gEDXH/0pMRAb?=
 =?us-ascii?Q?P6nV6xOSFWLdqC3+qG0dWscbuvT3wLOUFFRgmU705TeV6VMxxI93+QC9fMNP?=
 =?us-ascii?Q?CWUWldWO7TjT2gJm47uQ5HkfVip0DZ8DySZGS9zx9JP0ffONjF/8seOymuej?=
 =?us-ascii?Q?/Qr+nRuY/AoDsZvn4D4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5628.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e19cfc-a558-4c80-05ee-08ddf669210d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 04:09:14.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOmSFZ0geTmzimVAXqkUiT1fk8i4KVekobndrAv2ZEKJvZYMuw5/igEyHBno8xDbt8CO4s0I6cpMF0VWE58JBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9111
X-OriginatorOrg: intel.com


-----Original Message-----
From: Matthew Gerlach <matthew.gerlach@altera.com>=20
Sent: Tuesday, September 16, 2025 11:52 PM
To: Xu, Yilun <yilun.xu@intel.com>; linux-kernel@vger.kernel.org
Cc: Gerlach, MatthewH (Altera Corp) <matthew.gerlach@altera.com>
Subject: [PATCH] MAINTAINERS: change maintainer for Intel MAX10 BMC secure =
updates

Xu Yilun has kindly agreed to take over maintaining Intel MAX10 BMC secure =
updates, since I will be leaving Altera.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9da37c8dee69..b9c1bf9b9dee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12689,7 +12689,7 @@ F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
=20
 INTEL MAX10 BMC SECURE UPDATES
-M:	Matthew Gerlach <matthew.gerlach@altera.com>
+M:	Xu Yilun <yilun.xu@intel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
--
2.35.3


