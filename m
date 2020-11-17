Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF82B5C2A
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 10:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKQJsD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 04:48:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:7945 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbgKQJsB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 04:48:01 -0500
IronPort-SDR: p2Dn0TE+EKHbOElSqPM4CQtHxhHI4oTC55RRir23qDUZrstBt/JA7G+kabuFWb+A6hE4xWL3kj
 OnuSDPH/n3OA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="255606448"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="255606448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 01:47:59 -0800
IronPort-SDR: nvcvn+U0NU/PuWYl1EelTXBzsTkLLlwnZf1z3BJED9RqikX5RESLO86Xiucq29BleaTAVtKRel
 gWYKWUMiZ94w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="325104287"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2020 01:47:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 01:47:58 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 01:47:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 01:47:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 01:47:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogm6GEwCLzO2PmwovCpW/rb+Hp/vYQ9aBFlAqqT63r79G2qj0HWEDm3r8hPjQFYivRS42Nu0Azd44Q7z1/w54yt4Dxvc0vzNIvcvVCrnqMWvUdnH2HDHsvN4k3+lCsL7m9mQTHgUFjH+UBCoP7bmRyI/JjZbW3m6RE7At+NduhK+T0COlCaZR/9mBJYP47hKZ1xI2+I6LP4wShEUl5MV0CMAAZLAQMMYI+twoQsrU1pGn8xMf3NcAA2G6S7trPltBKS6nQm+mEEHuHPkubpa1AaZy0xmtocWFko4l3Rfp/XpCA1f688Kp5F6c+7uQWn7xWdL4HAGYhUi4KT6sGrjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONzGyh5ELkf4axVjkYZkPcKTb/n4yjXR+LbmmEm5CNE=;
 b=H9UCqSU33PUEq6m0BleACIWM/LJCtL/sf1F0Ma8ZzSmUQiSk2fSYp5VU22wvqAWAXJGJVAOrfq1GiM6aORsys0hEvry1DxZuy45ZKlsfi50pw3RBN24Wau7KJGsaOoZYzHyyJGBVwqjedF2GOLIkpNKDTIUx0InmiO3aTQqmlZAD4kQBi7iFslVRvTttMquOD/+lr64mpAStxlKSl0iBzdZU9mAvTQrA6x7Ttpy48YraXEGjnsnHI3/R/gwcthSnlKmzqnMd6LVkyH0aLuwJNL9q8qlBNMyPMdVL7sdAP3c0R0UqP+u6TiHKUzTGvriMgeRWrm2gEOFIHqU65Fzagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONzGyh5ELkf4axVjkYZkPcKTb/n4yjXR+LbmmEm5CNE=;
 b=q6J3+z6rXrbC9e8tI1f5+3Mmn6oIvxnTijm6WsLX9/U2X+K+62HlTszcxq2ICbf/cNQE7A68rZd/FGJ20J5qP1KFE1S1iWAW4LtnULTDePBCsUKZNMERnIe2qTEWzNh6dGEo/YdUJl58MRH5pay6YSHLbKzFafsky0FnrLVFhf0=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4122.namprd11.prod.outlook.com (2603:10b6:5:195::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 09:47:56 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 09:47:56 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Thread-Topic: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Thread-Index: AQHWvIBxykoMIcZrHUW2ir3zzcjKk6nL978w
Date:   Tue, 17 Nov 2020 09:47:56 +0000
Message-ID: <DM6PR11MB381979D8AEDC1F4EA8B4C2BC85E20@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
In-Reply-To: <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b6eb3e2-7930-41c9-b43d-08d88adddc8b
x-ms-traffictypediagnostic: DM6PR11MB4122:
x-microsoft-antispam-prvs: <DM6PR11MB412213846DB9B98162DD06F885E20@DM6PR11MB4122.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJSGI+iz6O0WQOqofEyf9IHUdElVvSRPD5IN8p3BpxjX1ODnR5kHVp24dWw0D9YzsDOmRYyosmIcNpfm8LAA1vTuZNYKJUVebuIlMgX7NrSVEHQ6Nj8Sx9nL9o5mCX9sMGQD85N/huOxBXdKf+MweKMV7XGZs499azy7JdS2/Jpp4Uop3bkDuIAZRhXUy49vZRkbFw6vtM/x4zHiJKLINBxuiaxPyzjju2eBKtMCHuAP/+r7BSS8NcF89dA6UKcVP2InkZcvdh6lfKEOZhWXFtHxE8dUnfu4uJh51DKyA5lQUIkK5qsZj0QOi/UcbkHdnYJI+2AS2DYcDiMU7239mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66556008)(110136005)(64756008)(66446008)(66476007)(9686003)(33656002)(316002)(66946007)(2906002)(83380400001)(55016002)(52536014)(478600001)(26005)(76116006)(7696005)(5660300002)(71200400001)(186003)(86362001)(6506007)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BTjjpUoaPSwHvGRNoq8UE9Ioz7IxGB3cQWXs8/GE5kF/qaIC9rpUaZb6O1cFT7U+dKuHkLsaNNuvdb4elO6O9TaA7ycgrz04L3L7dXT6X2cYs4LrYL9Jv9qAAmh3K2sVo1Th7gLS6UePdCPiw0KV9l2EvtmLaq2nBmgTHWPrm8dEcjBSVbRnAvmTIK5XYhnPEzutcVzGAGRa+Yx1wTHXnczydhL2rQWYH13Muymop7Tux/lbXmwxjgIsYm9hnjIRTVyCrcATYQQYh/TL9hGy7KohQL87SLlkCPlAwzyAvpi1zMm0TmPSMqOyrg1s7bFLYwuMBwZ2ZpVXkTBmMFOlgwurSVsHx/cj0qzddat2Kl9uH+vTUtDbyOvTH814wgvC3tN4FErloI+en8uxFTmXEX3flE5rtcLhIcrfP7O0N8Cx/YsG5LP3ni9WXCuLn4qhhIO5oS0UjXhsHbNY6jcrLwNLaIun3BijEFiRwTY6g8U6FsKheyrsSZjuN7yuwMBkYu5MLhV9nvIMdrvH9L5Kt0ixMVtt+nk/T14DiqZT5cssyqWqDndCoNO3xps3yFDOLbCmYyCNh76A554+i/O6564xOrSS9O5uh9RMwhvdyOZMc98um7EiOxc08d/orAMgeGuHC1hP78BMs566n3WJKA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6eb3e2-7930-41c9-b43d-08d88adddc8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 09:47:56.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpoSHREyauWjNMsB/G8yrJaPSmTsXWZfQN9lnV0M8B0DnRlhVYebmE/Xz6jUkd69lumHDPF2gGuXHThc5Ei2sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4122
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH 2/2] fpga: dfl: look for vendor specific capability
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
> specific capability can be used to specify the start of a
> number of DFLs.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  Documentation/fpga/dfl.rst | 10 +++++
>  drivers/fpga/dfl-pci.c     | 88 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 97 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6ffc74..c81ceb1e79e2 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -501,6 +501,16 @@ Developer only needs to provide a sub feature
> driver with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme=
-
> pr.c)
>  could be a reference.
>=20
> +Location of DFLs on PCI bus

Location of DFLs on PCI Device=20

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +The start of the DFL is assumed to be offset 0 of bar 0.

the first DFL

> +Alternatively, a vendor specific capability structure can be used to
> +specify the location of one or more DFLs.  Intel has reserved the

I believe this capability is used to specify all DFLs on this the PCI devic=
e.

> +vendor specific id of 0x43 for this purpose.  The vendor specific

VSEC ID is 0x43.=20

One more question here is, does it require vendor id to be intel firstly?
Or other vendors could implement the same one but with a different id?

> +data begins with a 4 byte count of the number of DFLs followed 4 byte

vendor specific register=20

> +Offset/BIR fields for each DFL. Bits 2:0 of Offset/BIR field indicates
> +the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
> +zero.
>=20
>  Open discussion
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index b1b157b41942..5418e8bf2496 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -27,6 +27,13 @@
>  #define DRV_VERSION	"0.8"
>  #define DRV_NAME	"dfl-pci"
>=20
> +#define PCI_VNDR_ID_DFLS 0x43

What about PCI_VSEC_ID_INTEL_DFLS?

Is it possible a different ID chosen by different vendor?

> +
> +#define PCI_VNDR_DFLS_CNT_OFFSET 8
> +#define PCI_VNDR_DFLS_RES_OFFSET 0x0c

What about VSEC_DFLS_CNT ?

> +
> +#define PCI_VND_DFLS_RES_BAR_MASK 0x7
> +
>  struct cci_drvdata {
>  	struct dfl_fpga_cdev *cdev;	/* container device */
>  };
> @@ -119,6 +126,82 @@ static int *cci_pci_create_irq_table(struct pci_dev
> *pcidev, unsigned int nvec)
>  	return table;
>  }
>=20
> +static int find_dfl_in_cfg(struct pci_dev *pcidev,
> +			   struct dfl_fpga_enum_info *info)
> +{
> +	u32 bar, offset, vndr_hdr, dfl_cnt, dfl_res;
> +	int dfl_res_off, i, voff =3D 0;
> +	resource_size_t start, len;
> +
> +	while ((voff =3D pci_find_next_ext_capability(pcidev, voff,
> PCI_EXT_CAP_ID_VNDR))) {
> +
> +		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
> &vndr_hdr);
> +
> +		dev_dbg(&pcidev->dev,
> +			"vendor-specific capability id 0x%x, rev 0x%x len
> 0x%x\n",
> +			PCI_VNDR_HEADER_ID(vndr_hdr),
> +			PCI_VNDR_HEADER_REV(vndr_hdr),
> +			PCI_VNDR_HEADER_LEN(vndr_hdr));

Why you need this log?

> +
> +		if (PCI_VNDR_HEADER_ID(vndr_hdr) =3D=3D PCI_VNDR_ID_DFLS)
> +			break;
> +	}
> +
> +	if (!voff) {
> +		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);

	"no DFL VSEC found"

> +		return -ENODEV;
> +	}
> +
> +	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT_OFFSET,
> &dfl_cnt);

I believe OFFSET can be removed. : )=20

> +	dev_info(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);

dev_dbg

> +	for (i =3D 0; i < dfl_cnt; i++) {
> +		dfl_res_off =3D voff + PCI_VNDR_DFLS_RES_OFFSET +
> +				      (i * sizeof(dfl_res));
> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
> +
> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
> +
> +		bar =3D dfl_res & PCI_VND_DFLS_RES_BAR_MASK;
> +
> +		if (bar >=3D PCI_STD_NUM_BARS) {
> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
> +				__func__, bar);
> +			return -EINVAL;
> +		}
> +
> +		len =3D pci_resource_len(pcidev, bar);
> +

Remove this blank line.

> +		if (len =3D=3D 0) {
> +			dev_err(&pcidev->dev, "%s unmapped bar
> number %d\n",

Why "unmapped bar"?

> +				__func__, bar);
> +			return -EINVAL;
> +		}
> +
> +		offset =3D dfl_res & ~PCI_VND_DFLS_RES_BAR_MASK;
> +

Remove this blank line.

> +		if (offset >=3D len) {
> +			dev_err(&pcidev->dev, "%s bad offset %u >=3D %llu\n",
> +				__func__, offset, len);
> +			return -EINVAL;
> +		}
> +
> +		dev_info(&pcidev->dev, "%s BAR %d offset 0x%x\n",
> __func__, bar, offset);

dev_dbg

> +
> +		start =3D pci_resource_start(pcidev, bar) + offset;
> +		len -=3D offset;
> +
> +		if (!PAGE_ALIGNED(start)) {

Is this a hard requirement? Or offset should be page aligned per VSEC defin=
ition?
Or this is just the requirement from driver point of view. Actually we don'=
t like
to add rules only in driver, so it's better we have this requirement in VSE=
C definition
with proper documentation.

> +			dev_err(&pcidev->dev, "%s unaliged start 0x%llx\n",

unaligned=20

> +				__func__, start);
> +			return -EINVAL;
> +		}
> +
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
> +	}
> +
> +	return 0;
> +}
> +
>  static int find_dfl_in_bar0(struct pci_dev *pcidev,
>  			    struct dfl_fpga_enum_info *info)
>  {
> @@ -221,7 +304,10 @@ static int cci_enumerate_feature_devs(struct
> pci_dev *pcidev)
>  			goto irq_free_exit;
>  	}
>=20
> -	ret =3D find_dfl_in_bar0(pcidev, info);

find_dfl or find_dfl_by_default

Actually the original idea is to hardcode the start of the first DFL per de=
vice id.

> +	ret =3D find_dfl_in_cfg(pcidev, info);

find_dfl_by_vsec

> +

Remove blank line.

> +	if (ret)
> +		ret =3D find_dfl_in_bar0(pcidev, info);

I am not sure if find_dfl_by_vsec failed, we still can try to find the firs=
t dfl in bar0.
Most cases it won't work, especially for multiple DFLs case. Just return er=
ror directly.
If someone implements the vsec, it must ensure that vsec contains the corre=
ct value,
no fallback solution. Otherwise it doesn't need to implement such vsec, rig=
ht?

Thanks
Hao

>=20
>  	if (ret)
>  		goto irq_free_exit;
> --
> 2.25.2

