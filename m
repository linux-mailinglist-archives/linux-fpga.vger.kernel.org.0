Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8360A2B5C99
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 11:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgKQKFe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 05:05:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:10093 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgKQKFe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 05:05:34 -0500
IronPort-SDR: FWz7vykoDyo/hV8RDQWsYWXTophoQBsENcVLOKQxNUbQ/CofYU7bGb8WtfVbG67Qb9CnCuW7Jn
 f58FXQra2ilQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="150745665"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="150745665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 02:05:34 -0800
IronPort-SDR: s8pur6JPQq5cjmBk5u4xXUYTBkosZD2Et7JGzAhIADIUXVwP2OOPagZFBIfpzFCgTa3aId3SNA
 Y74FBYfFsJzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="367815009"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Nov 2020 02:05:33 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 02:05:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 02:05:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 02:05:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 02:05:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpeKe+nHOTtWuMh1mPd3dyLvAhgMDUeroD4w9SXXVtdgfI5ut8VvvLNRIuW1RMN7IbPsDN4czKLAueVJBzjdk2cHohdQs0+LMg7dvw76VfalBvIH1nIKEaz+RykezVeWIgQ1ZNXALMfDiVUvVZpQLvuldcJO8Tc3mOpF1e+eY3CYlR8Z7JtAEo3Vw4yVMaGKWpbHKzRNco4caFo/5BdZIVjsj6vxpyrc/jP5qXVQEy4Vf3dIkc/ncvZfFLwXbjgaYl5vhpgiis6lqwgItGCc08gQW17YRc6Qy7ytc1rTMfTUC4Do8j61HkfwLJsWwt5KBgYs3uN6TgRAQGyvuzIlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB8H68Vz031GqcVLa7SJdS6jUE4JztC8fbdTyv3z/4c=;
 b=guAZY23LqRIpfEcXh4rBhxsudX39dAkBvowWXDybT34YZLBlk6lfgYp0P5F+T4B9ReO4N6iT+e+we3HlpJhwssuCPG/cQG0aHVNeDyXMXKS3HQ9ZGkg9a9uKr6+A85tTgW2ebu9Wq3IM1lxdx4lVTTY52cQT9ktQUbK1zKxPyq2JS6umi0aDmhr2C/Ln3kQ1jGyZH3LHulbyy+9waejfOz8nCbOEC5L9QWyfVWD8qSL2+MM7mx5/kVWNtn6n9ytrzj2W5KLiqf9UKGmv0+WZnXqFK61CF58mQL84brgJ3jkw1TQI9711+Nhddv6PlliX8yrufMdSHvUdVA365YHmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB8H68Vz031GqcVLa7SJdS6jUE4JztC8fbdTyv3z/4c=;
 b=p7c+jlirf4fNuZt5NyJQ5a9qB2W4+IgPpoC9tDMPUkNNzqO+deQI+jqPsxcNwElbfQtXPwqus3kHN9qfF8wNc8p06/8l2Gakz6oeYiCuRCj2i+JNDsqjzmsKkwENYX7COyV3aEXlNK/j7tbNJw8le+4A8NL1daAg8Uhh1L8aXHI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2571.namprd11.prod.outlook.com (2603:10b6:5:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 17 Nov
 2020 10:05:32 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 10:05:32 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
Thread-Topic: [PATCH 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
Thread-Index: AQHWvIBxozGsy0BNp0CzNAbUV8wEW6nMGFow
Date:   Tue, 17 Nov 2020 10:05:31 +0000
Message-ID: <DM6PR11MB3819F764DE20B0050A548C1F85E20@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-2-matthew.gerlach@linux.intel.com>
In-Reply-To: <20201117012552.262149-2-matthew.gerlach@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: b0a1d2a5-f52a-41c5-1525-08d88ae051ac
x-ms-traffictypediagnostic: DM6PR11MB2571:
x-microsoft-antispam-prvs: <DM6PR11MB2571A0E0CDC562E45BEE09F485E20@DM6PR11MB2571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:166;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBiC/X3PE48Qk9SwFgu1wrz0fsi+s9r7ADkQZBpWgHOfp7sQNTz4gmf7U0UJLd/vzdNU4kI0tJMao29c7S0bOy1ofpy62oal7OUhLGqqEhdDC2jb3+KurtVaZSHcb3IbUcsCffcIowqxqtNGurxv/iFhV+3to9JDjIaMQDOmQp14ez7ahXMcap1DFOwOTGWb6u+0NTKdl+5RWpSo3m0Obf1nVsJwxdeFbkesRACfbCQhajSrQG3/FxLJTdHiqxY9YTVl5dJaqi8WFVAAxomZSs4rOiD9FHlci58yYoLCoHKi8Bro5tAIShu7LnK3hScZlwarmulfGQrbodsNKlSjcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(5660300002)(110136005)(8676002)(9686003)(478600001)(33656002)(83380400001)(66946007)(7696005)(316002)(64756008)(66556008)(66446008)(66476007)(76116006)(71200400001)(8936002)(6506007)(86362001)(55016002)(2906002)(186003)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hhrYeGaFfUktjzEltfz8JBT97DM/kbj2p2Lzla4IRFZPdEKOihDyRQ72n8GlLSwi/WaX2WinpLMs/F4C5Nu2hi2P648bm1tfDEhMI0MjtzDcyIrJ1gUKLwOF1SL4GRxRKh+3NcPwRrDQ6ZnqozyN/LtDJkMLoQYgE2z8PaXgYDQ/Ub1I4JCF+NMTQRfjPit0N627DzBvqmke2RcwHrFqMBtziWk1gH8MV22504mrkXv5ej9Id4F68XpMMW/OZEJVqbdTgmA4aZ7qJfJYCke4cANIL7j/+Hv+XV29HDC+YtYupdj3b6DwQuSWKJu/tJGIkNEIzej2eTRAx2lwBHa93u1KP9Jl+VNqJtZk8H1WUwZaJGeX/InRjOLHDm7ETUyKf388DdVxclKI8E/F4eDsCoVlXlionvPcF06nFfxjQqa+9t8ncwyYTR9U8GWTO3ulL3WDXa8qDhEwS/Zs3G8yVsiZs6csJovZhIYzYMKPPdsNdPjGpyaC0+qp4PQpjNX6P3wPgSzSdhukDcBxdkMkPutkNn8MM5Ej64lSkq+lasggjTXPcZKyxL/RFjtcIZJXqblKsdpJ1mbUjiGYRH2115J9iFv9jWRKJxhai5ALT+Pb5MlVIJizpl5dXQjtqX7RTmhlfspcfbtaiK7UBg2t6g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a1d2a5-f52a-41c5-1525-08d88ae051ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 10:05:31.8705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esB+GgmOv573SPQVpqE/iioDU/vl0Jx+hSD08Au48xa4QuulnBprgAM8zytKOnPI5XPZr7IIMOsSWEOVMgM60g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2571
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> In preparation of looking for dfls based on a vendor
> specific pcie capability, move code that assumes
> Bar0/offset0 as start of DFL to its own function.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 86 ++++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index a2203d03c9e2..b1b157b41942 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -119,49 +119,20 @@ static int *cci_pci_create_irq_table(struct pci_dev
> *pcidev, unsigned int nvec)
>  	return table;
>  }
>=20
> -/* enumerate feature devices under pci device */
> -static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> +static int find_dfl_in_bar0(struct pci_dev *pcidev,
> +			    struct dfl_fpga_enum_info *info)
>  {
> -	struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
> -	int port_num, bar, i, nvec, ret =3D 0;
> -	struct dfl_fpga_enum_info *info;
> -	struct dfl_fpga_cdev *cdev;
>  	resource_size_t start, len;
> +	int port_num, bar, i;
>  	void __iomem *base;
> -	int *irq_table;
> +	int ret =3D 0;
>  	u32 offset;
>  	u64 v;
>=20
> -	/* allocate enumeration info via pci_dev */
> -	info =3D dfl_fpga_enum_info_alloc(&pcidev->dev);
> -	if (!info)
> -		return -ENOMEM;
> -
> -	/* add irq info for enumeration if the device support irq */
> -	nvec =3D cci_pci_alloc_irq(pcidev);
> -	if (nvec < 0) {
> -		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> -		ret =3D nvec;
> -		goto enum_info_free_exit;
> -	} else if (nvec) {
> -		irq_table =3D cci_pci_create_irq_table(pcidev, nvec);
> -		if (!irq_table) {
> -			ret =3D -ENOMEM;
> -			goto irq_free_exit;
> -		}
> -
> -		ret =3D dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> -		kfree(irq_table);
> -		if (ret)
> -			goto irq_free_exit;
> -	}
> -
> -	/* start to find Device Feature List in Bar 0 */
> +	/* start to find Device Feature List from Bar 0 */
>  	base =3D cci_pci_ioremap_bar0(pcidev);
> -	if (!base) {
> -		ret =3D -ENOMEM;
> -		goto irq_free_exit;
> -	}
> +	if (!base)
> +		return -ENOMEM;
>=20
>  	/*
>  	 * PF device has FME and Ports/AFUs, and VF device only has one
> @@ -208,12 +179,53 @@ static int cci_enumerate_feature_devs(struct
> pci_dev *pcidev)
>  		dfl_fpga_enum_info_add_dfl(info, start, len);
>  	} else {
>  		ret =3D -ENODEV;
> -		goto irq_free_exit;
>  	}
>=20
>  	/* release I/O mappings for next step enumeration */
>  	pcim_iounmap_regions(pcidev, BIT(0));
>=20
> +

We don't need 2 blank line here, remove one please.

> +	return ret;
> +}
> +
> +/* enumerate feature devices under pci device */
> +static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> +{
> +	struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
> +	struct dfl_fpga_enum_info *info;
> +	struct dfl_fpga_cdev *cdev;
> +	int nvec, ret =3D 0;
> +	int *irq_table;
> +
> +	/* allocate enumeration info via pci_dev */
> +	info =3D dfl_fpga_enum_info_alloc(&pcidev->dev);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* add irq info for enumeration if the device support irq */
> +	nvec =3D cci_pci_alloc_irq(pcidev);
> +	if (nvec < 0) {
> +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> +		ret =3D nvec;
> +		goto enum_info_free_exit;
> +	} else if (nvec) {
> +		irq_table =3D cci_pci_create_irq_table(pcidev, nvec);
> +		if (!irq_table) {
> +			ret =3D -ENOMEM;
> +			goto irq_free_exit;
> +		}
> +
> +		ret =3D dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> +		kfree(irq_table);
> +		if (ret)
> +			goto irq_free_exit;
> +	}
> +
> +	ret =3D find_dfl_in_bar0(pcidev, info);
> +

Remove this blank line, and maybe switch to a better function name here.

Thanks
Hao

> +	if (ret)
> +		goto irq_free_exit;
> +
>  	/* start enumeration with prepared enumeration information */
>  	cdev =3D dfl_fpga_feature_devs_enumerate(info);
>  	if (IS_ERR(cdev)) {
> --
> 2.25.2

