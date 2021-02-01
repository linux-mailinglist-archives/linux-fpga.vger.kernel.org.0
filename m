Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5ED30A82D
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBAM7w (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 07:59:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:59991 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBAM7v (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 07:59:51 -0500
IronPort-SDR: NNU8vA4OFF16xiFXjK4hrJ2O7H3Yjy51XT02pJxEovjQjn4R/s1Fm7nGBC+KTZDIKUa5gQ4f8h
 9j5XhtFDOiFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="168360574"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="168360574"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:59:09 -0800
IronPort-SDR: DSq0JabW4CQSBD5h4C8e7aGsxyKMz3nld28U3RGUDQwiPG3KzoUkRli2669pTVyPSxlVwoAU1a
 1BHcP5oV5OuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="412410649"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2021 04:59:09 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 04:59:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Feb 2021 04:59:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 1 Feb 2021 04:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCTmvArEvanOY2PjvDCYXMRUZ5PDtTdU63tTdBGl2ExfG8nXUZEe8yOQb4Q/5/y3HO1xF/6jWLDpTsaVG0BIDueIjT6OZqqkFkvYyQBBjnnULFdodjWbPF4QIJ+3yZDs77XSaix5W95+BpzVYocO6MRJWv1ntzHlRTxRYEPr7DOAojS78RAE6oRdIxednaDJB+50S0oUoGn4axNzbmx0EG0osdxc71SDhf6jdzwC79NMBjJkmPxYsgnpPJmN3AL0Aokog46F3BkUBattRLDgk0QnJ3LCfWYTSd/XrUXaBPWLrk019rZDhvrBZn9Q60raBNDcIMqHsp/YDCD3hkxsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnk0TbCYinU2R/kmHMrA1L+PmZLAfl8jxdUK7YSEA+w=;
 b=bqLd9XDNMqbM4C953kEmkuPIG84EZGparBD26+zuEFJkzfwxxEJASFEsvlRo35X/7iKaBMmtTQHXT7IN6thhltTtno7rI+OwhVeu1xj1E2uGC1tOv9+z3ie/RDu5HMqUSOmgq8T5Xf4uYLRyn5LvoRmdx8Lcfadpo2omhrifAzw13QE8mqXaX6/D+Tr02eHliJdh9d2mcvCMzHlD7WeWQJJuGEFfZ8mWCz9D2hG0mR+tHMuhukiy9lc9nO1g3Ht5nHk3/Wtjru2n9qTKFgFvZBQLFfLV3AUvomKfmZ2aJqLLLdq9FO2lnU0Bl6FHGs2E+V+dI88/zO30uRbMpMOnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnk0TbCYinU2R/kmHMrA1L+PmZLAfl8jxdUK7YSEA+w=;
 b=lMVk1wrWEHKr+HLS89eXYx/nsr8e+qSrwnW4v3sK8mDJLakbYvibH12lVXJErrcEzce31ZHNxbsL1AjsHZo1ekIF3bkeCkBZFzjtIE08CMGaUVfAvjPH83go1Orj2mp0Cvvkw8EHqv/sHumDhUveyTnqVKRUYNI3qQ5pDYKDmJo=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2668.namprd11.prod.outlook.com (2603:10b6:5:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.27; Mon, 1 Feb
 2021 12:59:06 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3805.019; Mon, 1 Feb 2021
 12:59:06 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v10 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
Thread-Topic: [PATCH v10 2/2] Documentation: fpga: dfl: Add description for
 DFL UIO support
Thread-Index: AQHW+F0f9vj3m263KUqZYocQ0iqUE6pDP1Tw
Date:   Mon, 1 Feb 2021 12:59:06 +0000
Message-ID: <DM6PR11MB3819D4E1E69EE4FE405864F685B69@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1612157883-18616-1-git-send-email-yilun.xu@intel.com>
 <1612157883-18616-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1612157883-18616-3-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc9c72b5-7bb3-49f8-6c74-08d8c6b12868
x-ms-traffictypediagnostic: DM6PR11MB2668:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB266837398FD66C1C127B597485B69@DM6PR11MB2668.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvsyLikCuGsIrBuvn4cNuHEGv4FFNYUKqePI907un5TC7EWAv0uZgnJ+9u0+JrgvflfHp7T1/TOpdU/TVMlD229gm5UqTHaylr/RD2bd+K3Clam71khuQesjFBGTuwH2HzQWI4LvB685siNvYByzvjHgfo+GpIVmqmWomv2RG+Vqtk0xfceHYPEg6GQ1dPHgYR0mUODn3HKFCCPBYN0Wue5OQizpRiyeZBtMFvtgEpgMoQg/SmDnyCHJ+oXCuaAneul5hUSIUC37gDDUMo54qe938xaYpDpz/aGvUSvZOtEkXLnIF+inR2D/Nb+bBw4caa/42BXhSZ8cMfV6XTu0nzM6WpHmvYEt+eKT8BE7BXGtPf9fep0AQn8gT3lhIBXTCzeX8YZT4VEj7BMqrbQ+hUcPKXY6liip9BWb2v19uAvhR4KiDmAoMLAuYrBxXQaZ2eHpzWyaFfCbf2Capq+qb049kZ/zTerW0CtPxHjF5fkdZrbtaD3fUv4KVCM1jWAAwLJJZBmEOsmzgtUFLrIztQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(316002)(54906003)(478600001)(26005)(8676002)(110136005)(6506007)(186003)(86362001)(83380400001)(71200400001)(55016002)(9686003)(8936002)(4326008)(66446008)(7696005)(33656002)(5660300002)(66946007)(76116006)(64756008)(66476007)(66556008)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?onnRb0Wj6gv4IOjq0NE78hBVFW6+bIUh4pGBsBgdLlbht3hhQQaFGSxIk8CK?=
 =?us-ascii?Q?wAj0jzEO8Zf8ve4lqvTQoODNEmqNU/bSOVroKnN+u2y0LzZFWL0fzt22H/Xw?=
 =?us-ascii?Q?KoBit8fL+qhgQUIIet2+zXKgpXFyw4f+EvAclwCQbOB5s+LM0AsGylUBhQU3?=
 =?us-ascii?Q?SljcboedH965jgiGsbDPcCHkZGOxrgOG5HgM6fPYmz/UCBpAfB9RZT2jQZmF?=
 =?us-ascii?Q?nKSkGmx4tVAvXUhs4OGYjV1jWDODyvZlSPCOQw6zn1LeAuyWypD+TxKQw5r6?=
 =?us-ascii?Q?HgEwnbZA4C+m/r3kVuI5yoV5pVae8DsyorEQBXfbFwOxcRaxbpLtNfvb/MIM?=
 =?us-ascii?Q?TsDE+CoAmcL7xte73IClb14lB+AT6D1X3/5lGCUv/dLLptRqNelguRWPC5sr?=
 =?us-ascii?Q?vLK7TNVvkZV3TrHfe3n+3/+PHgIuKqMRhOL5GtUhzlpWoVrABTGUz4h7jAFe?=
 =?us-ascii?Q?9+3p961RdqYs867JrAOefjsouVUj1o3M1qbpbQGEPSXO7IeQsPHY0XKmz6Pa?=
 =?us-ascii?Q?r4rVv000Co05nVS99qULIgXSGlLiFJZr1AWrZT72zDa36XEsnsNHX/TL3TQ+?=
 =?us-ascii?Q?qerWb98CXCALBlMkVji1qJUHs9WQ21Lxj358WOzbefHBKqzt1jKYQ0iV2u75?=
 =?us-ascii?Q?tXcNG2ynabASKB0LP7EY/JdlsBFNb4dOApgZHdN9MEtGrxV8wSjCIAqvUw6G?=
 =?us-ascii?Q?iNDjNUi35zN3n9itySziXkXa/eJO9Qyanas7JzxhPkCp2ZUlPtB/0A5GWUik?=
 =?us-ascii?Q?dqyIUg3zWozRwRJee9p2WbkkWyNVft3Szdeq8Xr8Jz2/FVf0mwMO9mhwJYTC?=
 =?us-ascii?Q?dKpSOveUmDB1wuZmgSUVtOH7ABeigyZL4vKxHiussyGWb4iX1l3LHcxPghsK?=
 =?us-ascii?Q?M4mfzJ5XtmxUv7nhLYEGOLtfkf+UOEAJsEkxrOzCu+794KyslhPF3XZHsIkp?=
 =?us-ascii?Q?dZAPD/5zo8vaHEbAV8QJtZf2iurB04ngfklpEJOK/8Gj4NiRGzauLu6FUo4C?=
 =?us-ascii?Q?vEQI5KXHTWX+gAeUr1cZne1Sy0fkecro2AtnM41xFPld5f568TC0VKIfEdQl?=
 =?us-ascii?Q?DyKCiFx7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9c72b5-7bb3-49f8-6c74-08d8c6b12868
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 12:59:06.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbfCZsDxK+4kdPFm9yqGqfaFMJ8sZR7OD2E7t/WBpFGKEKKulrJJdokB8QFD5mpKXzPhaiU3so/hfDdQNAM46w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2668
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v10 2/2] Documentation: fpga: dfl: Add description for DF=
L UIO
> support
>=20
> This patch adds description for UIO support for dfl devices on DFL
> bus.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> v4: documentation change since the driver matching is changed.
> v5: no change.
> v6: improve the title of the userspace driver support section.
>     some word improvement.
> v7: rebased to next-20210119
> v8: some doc fixes.
> v9: some doc change since we switch to the driver in drivers/uio.
> v10: no change.
> ---
>  Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index c41ac76..e35cf87 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -7,6 +7,7 @@ Authors:
>  - Enno Luebbers <enno.luebbers@intel.com>
>  - Xiao Guangrong <guangrong.xiao@linux.intel.com>
>  - Wu Hao <hao.wu@intel.com>
> +- Xu Yilun <yilun.xu@intel.com>
>=20
>  The Device Feature List (DFL) FPGA framework (and drivers according to
>  this framework) hides the very details of low layer hardwares and provid=
es
> @@ -530,6 +531,28 @@ Being able to specify more than one DFL per BAR has
> been considered, but it
>  was determined the use case did not provide value.  Specifying a single =
DFL
>  per BAR simplifies the implementation and allows for extra error checkin=
g.
>=20
> +
> +Userspace driver support for DFL devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The purpose of an FPGA is to be reprogrammed with newly developed
> hardware
> +components. New hardware can instantiate a new private feature in the DF=
L,
> and
> +then present a DFL device in the system. In some cases users may need a
> +userspace driver for the DFL device:
> +
> +* Users may need to run some diagnostic test for their hardware.
> +* Users may prototype the kernel driver in user space.
> +* Some hardware is designed for specific purposes and does not fit into =
one of
> +  the standard kernel subsystems.
> +
> +This requires direct access to MMIO space and interrupt handling from
> +userspace. The uio_dfl module exposes the UIO device interfaces for this
> +purpose.

Current uio_dfl doesn't have interrupt handling support, right? I guess we =
need
to make sure no confusion on the description here. other place looks good t=
o me.

Hao

> +
> +UIO_DFL should be selected to enable the uio_dfl module driver. To suppo=
rt a
> +new DFL feature via UIO direct access, its feature id should be added to=
 the
> +driver's id_table.
> +
> +
>  Open discussion
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial
> reconfiguration
> --
> 2.7.4

