Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA992E8FCC
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Jan 2021 05:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhADEYv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Jan 2021 23:24:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:24057 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADEYv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 3 Jan 2021 23:24:51 -0500
IronPort-SDR: 2lhF9D8HP0f0Lc05zmfzxLK1UOiAKpOFUom6+VonXbwXw2q3Irj1Cx/CCw5tTZiGz8LdxtCjBV
 +M8dpObDiIeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="177010467"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="177010467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 20:24:09 -0800
IronPort-SDR: HE1fInz+x1iB+5xmI+bG8/PC3Z0ylLGOmQvzGGgp+74VptWWAiL6NtsKr1Co3lgDEgejr/yxEr
 Ri1kFbnIseuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="360642711"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2021 20:24:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 Jan 2021 20:24:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 3 Jan 2021 20:24:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 3 Jan 2021 20:24:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpNZZ8TdaYxYhVf9+iPmnnnhOGNcgz/KTm0FzTz3gnJV5C5/Fm460Je8SXZ50CJ02XohKckdw+cihWwoI5f9GFxD8LLByOMDneh/13AWk7G+vrCtNG1BfX18+LFB0XvetbR4HAuogqyTj6hWxjb44oWhn2Kd/s/sU7X8DuQyJBMm4gux+qoyIFa/QqLnVgyy7f11Z3G4vC22aKlvvp+taV8jIgplh6IvtC1kyutNZwzC2FQw8+PXN81isczNz+WrifKzaNh4rm24qrOhJw2+rGs7fZO+BuV0Jp9kK35Za2ylL57BbkyDg8oEu+Et1AO6vk8Hm1zqIemSvX1X7e4VFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uT0OdlET7B6ZCtuWUKJfj7s4H9gQNvCSh+vH9cc/vo=;
 b=nMHF/W3VpulboHHhTiqhDMgnK/ZxCJ/cf9fFb2X1ti8CvLKa8yUDa5DRCgsASHZRG23OGMoB7kj1xMs9kVXCEtsuk7t+rr4/AQpzHlXpi0hxLDeo5u8vUaKLhJyAubZiOuRsTkQhSZUmvam+MwM0OWkMS+RPzMBUzN5NMj6q0rhwqQv0lYAXao4eXsI91XKbHJGSPNCbppCgATykBdo5ETYDuGN6eXGUosQG9cIE75MbiJGVPOeINPjDcRsMSZH4dDycmCJZiG/n3OiJOoNoje/GjydCxHyaRvYYeGkD0souhiNjS2zJSmRdcgCfFJtWa275bwu7PXf2pt1ts4GbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uT0OdlET7B6ZCtuWUKJfj7s4H9gQNvCSh+vH9cc/vo=;
 b=sq0b9edy9FQnv95EG7Xsbiih1NlEBZXmFcKjdRT0JKq5yXrxK13rhoZcXqZ+M/wuxWDCqGPTnAF6zhlP2nOi5pX5qSRiS07wtKPmfRsRICt8q+OyRoU59Sf2iEyhqNwMJBxNo7sxiEFlRj8vfhn1qO2lxlqS7ABccy26Qvx1Lyg=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4219.namprd11.prod.outlook.com (2603:10b6:5:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Mon, 4 Jan
 2021 04:24:05 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 04:24:05 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
Thread-Topic: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
Thread-Index: AQHW4LXgma4yi9zC/USJUb2SbCDuqKoW37bg
Date:   Mon, 4 Jan 2021 04:24:05 +0000
Message-ID: <DM6PR11MB3819096D79EE63C4110EDBB485D20@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1609557182-20787-3-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a92e2128-1bd7-4c9b-57ae-08d8b06892c9
x-ms-traffictypediagnostic: DM6PR11MB4219:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4219E5CD4B74E91AADDDDCFA85D20@DM6PR11MB4219.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIRwwRXlf9uCW5jb7GRku2UySM6iRaOnmC+3qbJR2eU3QDqDy458UTGdy6dGWkS6PXjrsw34LUbmLVQTPvjdjz98bOC8VblOgM+FyyHs+KUXTi1L9QoY8ohiUWpXFwonPL9e5IZi7hjReWNNid8DmE3GT7RWgEs8WxHp0SOSluXo3QWQdtRl3Ceb4RkKb13/yIP/PjIrRAIj9VlPG837IXfpiI5kf0Iz9T8Na/kQyBiL16TO4dqBYVgDOhKwHf7nB89/nZbq3UEZRg/GuPFsNbcAWezZzKnEwkz3ack1oqbzK5aua2BhX553cCGqTf4LAT+4TTXO0+wJp7oDbZVCA7yvFga2WRVRRdBNVPjlutVMJNBoEWKcMdGiBGT1tnLtiNtQAMGQl5SGzfsuoTcTfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(478600001)(33656002)(26005)(110136005)(186003)(86362001)(5660300002)(316002)(4326008)(54906003)(83380400001)(52536014)(8936002)(8676002)(6506007)(7696005)(71200400001)(76116006)(66476007)(66446008)(2906002)(64756008)(9686003)(66946007)(66556008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GxFq810hAnoJyu1Kyh+k/UPT0GtzvqyUlsSDvJOoNwCOlbvuT5E55Q9h6QlI?=
 =?us-ascii?Q?75cYp3Ma+jYspVR9CU/H564KME/PrwIk8a0vpgf2OdP0bmEihepwCi5/TbQS?=
 =?us-ascii?Q?ww3hTIKH6nfExgG1y4MKj/wSHtxkMoA6UlWraCirnLvN/k73CpUWid+3CtYR?=
 =?us-ascii?Q?dI/j9Z9TXYFOgfZvB2eD2IkYfCcMShfBhl+hDbKH06G+Xp0Ny/vvIyI5RbJN?=
 =?us-ascii?Q?r6WSQmtO7tHR2Ju2Ej6I0764FverAq+846g8BEXH7EtHPO/XQgDT/UHJ6tYL?=
 =?us-ascii?Q?r9Ha3Hf56ARenjlU1aS8oLKUBxsr26QXvYF/HN1IO1LqqMwUoXWRwm47ejKA?=
 =?us-ascii?Q?0AB+BBJQHtgP5sC3knLpEsOXG3Tp7pQVaxfuMhRfHUomAUD5fkjF46RQ3WDk?=
 =?us-ascii?Q?rWdgX7rIsNM5oSvtlVwbEmIssXXUaryrPmtsSgG20QQPKKk+SNodKtdfNPor?=
 =?us-ascii?Q?f9zeyUWQNqEfBZLF+gBdXr3GWRgs/iD/3AnwBH6Z4yulrDN8L3Lbsc6JqABM?=
 =?us-ascii?Q?1bqzX+p5bSQPpRQGOusm2GzQc3j+TYLGcsL84i9RgytHTKw5ePM85pYOTznY?=
 =?us-ascii?Q?3qFIa+y82EbFJXTwCGu0GuPsD4PRES4ycEpF/Xv/NYu1hnmBrOcOO/O/7eJM?=
 =?us-ascii?Q?HPFpkYhfPD61kXphFTonEc3ZY1vUZSnG86thzcf307Qlinob2bg9JcFjMeHJ?=
 =?us-ascii?Q?qOVHCbprqEOsH8LttrOojPB2WKn46ZmshK3KuawzljiRY1JILZ5cavF2bjhK?=
 =?us-ascii?Q?IA8sjdKfk98w+ck30Y87hZGgKocbS/H8SjNjxdl32+2AyV3SAP6XAECLEmuH?=
 =?us-ascii?Q?Mub7FubZwdVnqqvisc4VhTqxGhhKMHNZHE98mRNEYwoVMI8kYXxAieQmB1p+?=
 =?us-ascii?Q?tW5lsiziDshnlKVwd6jLlgHjW6vZ6WuLbIsyOrL/lidWMCBfi78FwmrfwCC5?=
 =?us-ascii?Q?KuJCDo1Ga9JQD8g7BEiI+/QuaZ1wzDfMiqYi7dcGh6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92e2128-1bd7-4c9b-57ae-08d8b06892c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 04:24:05.7881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKUnrgD8lflGinhCZIBBZAdxmbfsmc4Club9FVxMBBppDhWwJpOZslxMUNBw5yGGwDPp5QFtUAOCami7qo3RHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4219
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL
> UIO support
>=20
> This patch adds description for UIO support for dfl devices on DFL
> bus.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> v4: documentation change since the driver matching is changed.
> v5: no change.
> ---
>  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6..b8497f3 100644
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
> @@ -502,6 +503,29 @@ FME Partial Reconfiguration Sub Feature driver (see
> drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>=20
>=20
> +UIO support for DFL devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

I think the main purpose is to support userspace driver for DFL devices, an=
d
UIO is the option for now. Do you think if the title could be userspace dri=
ver
support for DFL devices?=20

Hao

> +The purpose of an FPGA is to be reprogrammed with newly developed
> hardware
> +components. New hardware can instantiate a new private feature in the
> DFL, and
> +then get a DFL device in their system. In some cases users may need a
> userspace
> +driver for the DFL device:
> +
> +* Users may need to run some diagnostic test for their hardwares.
> +* Users may prototype the kernel driver in user space.
> +* Some hardware is designed for specific purposes and does not fit into =
one
> of
> +  the standard kernel subsystems.
> +
> +This requires the direct access to the MMIO space and interrupt handling=
 in
> +userspace. The dfl-uio-pdev module exposes the UIO device interfaces for
> this
> +purpose. It adds the uio_pdrv_genirq platform device with the resources =
of
> +the DFL feature, and lets the generic UIO platform device driver provide=
 UIO
> +support to userspace.
> +
> +FPGA_DFL_UIO_PDEV should be selected to enable the dfl-uio-pdev module
> driver.
> +To support a new DFL feature been directly accessed via UIO, its feature=
 id
> +should be added to the driver's id_table.
> +
> +
>  Open discussion
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial
> reconfiguration
> --
> 2.7.4

