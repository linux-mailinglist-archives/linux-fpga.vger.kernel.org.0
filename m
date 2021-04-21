Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C793664CB
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Apr 2021 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhDUF0b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Apr 2021 01:26:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:41963 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhDUF0a (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 21 Apr 2021 01:26:30 -0400
IronPort-SDR: KNXpopj1UAnwPCf/HgH7yn6W92JHgOKRSmj1vCKKEipvLTiJzqIiwBThlZCuY/FOwmLUMU8mdk
 oZMWDmeu8aqw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195755406"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="195755406"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 22:25:56 -0700
IronPort-SDR: uhkcMcOD6kjM/Bzp1ZwEM5si4gVAd49m30fyjpqD9Vli+/qZ6/vN+0WJeWXTAYnULqV+b/s9zv
 MTS48usMquiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="534775665"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2021 22:25:56 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 22:25:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 20 Apr 2021 22:25:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 20 Apr 2021 22:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkEQuLohNC+2PoQwpMCUz2+na6hcz1+MkhXOwacvQWlvEEOhNys50MFVh3Lx++fDTPgR2NQWn79TvFGcI/5ZmMIBf7TQfKeAdUL7mJKITJnHN/olNWdDDNG6Y6d6/W8k9ZZZDnzIIcWqVv1XxgD/jmQi/XGXWUzpsXt9PMpJWg4ju0ZUQPsw3SogCqjtBNcc0UdTcHeCdlAf7iZbjw21P1cRatwMiYqxoPwZT87y+VFFzQRNBkLF8LauLh7E+smQuN49So4OkRTiVBgCyMyP9Pj/mGekUGvM10r7MGoFeMGgXIJCHMTnz86vS+EawsfH4b0bs2DKPY3hWWtSjEJ+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9R3Vc6Uo52eW94bm80oW1n99ja710FxrcntkSLQidY=;
 b=PqF9uycVeipOLPY0iEufZQwIoor9lyj6+oTnBo9DLq4+LYqUFykZH2wTi5IuDmJASmLZU6F7r2iKaMCSrXX5eNXx0A6JZlzt4A3PcbdbObbySz8ihgESbt+y8pdMXDiiqL4Pyxyh4Gt/HFGhUxcBh6WjdDNRbh6AVZ8lUltS1DkG2e70lrcgONmFjgY4rmUDuwBe9f1B8QsMWFU6Lgz89t0/IVh5Cv5hmwVApJGOjvk0rAxwM0c7QWZpTx4oRt7rj90Gsh1uFAKJTaG7rwYD8QHFt1WhNbXhnSPxAmrKf5zqJcRKHe6ssVRhJIDJuR1xq5g6rbmpE4eiff0oDHUthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9R3Vc6Uo52eW94bm80oW1n99ja710FxrcntkSLQidY=;
 b=aV73rOLpfSeJVbPycg87vHt9ISEZOtSbh30wOyhAQEVympkACsM1sS6dZKHWTeWOQY93opizQErx/mezHW/c4abqc4XysKDltkypOhSnfbKOY0aTb7rc8ONnsba/km/DZS5dSMGQ+tEXhxbnJxrUNkcQOC/JlMLe/b4lFv2tt9k=
Received: from BYAPR11MB3816.namprd11.prod.outlook.com (2603:10b6:a03:f8::32)
 by BY5PR11MB4273.namprd11.prod.outlook.com (2603:10b6:a03:1c9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 05:25:52 +0000
Received: from BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::1c35:a545:adc:e8c0]) by BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::1c35:a545:adc:e8c0%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 05:25:52 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>
Subject: RE: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
Thread-Topic: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
Thread-Index: AQHXNgpK6sZ5wt8PgU2xWx05XVpyOqq+btGQ
Date:   Wed, 21 Apr 2021 05:25:52 +0000
Message-ID: <BYAPR11MB381637F0EFFAFD57902EE47985479@BYAPR11MB3816.namprd11.prod.outlook.com>
References: <20210420172740.707259-1-matthew.gerlach@linux.intel.com>
In-Reply-To: <20210420172740.707259-1-matthew.gerlach@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b404b63-ee05-4123-62d1-08d90485ee7e
x-ms-traffictypediagnostic: BY5PR11MB4273:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB427301D61464E84B9308FB2285479@BY5PR11MB4273.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:238;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxdrOMajR8aUflYqMahGkby8FOhriCQSxiEBPAJ3Tg/a5nAfI2IhXYih6VNmc+HRnFEdykEs2sM50HaPRh2F+yOahLsJTN8mCUzNE0a73XrwUOAXFkkXVjN0mCuMNmTSnT47R6sU/P9GUaGA83vvQDqrP6g6anWgT/AUnplFSh78BRMQKJer76fQopCtykJAiFMorHoWbGcRUwsEi8oE0P8cT+qxfrFl5WAj2xOjIfGci9TWtRVlq62wzFt4+TWPRVLkSC9a3OGzoPYdA8CBqckD1gfuAY890N3QqhbJUvvzhCCEQeVw1RX2q+YRHDix8l5Czp3o7Ehu0rEl0+C4MR32PwTPfRr+CELNMxxcSAzmB1Ri6T9aoskrhvutPD+us66kqtZLnViAgoN6iqZboD2POSthWIFBg3o0mDONUr9yhhVbQH3fLuNTllCIT3c4aceR5MqX0CI7EGSA0x1CIGlXQCVheJd6+hwXCYcvdD4WagXobvlNKpgIg59Dhnq+QisuvNqcNbUA7Vfl/AqLfhljEJRBhckrkO6aFpOh2+XyvPBPFgGWjjjAizdLd1yqKffgTY1T519NpIUtV1elD6stlyhY8OdtPX1/JSfiVcs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(186003)(86362001)(64756008)(52536014)(6506007)(2906002)(9686003)(55016002)(83380400001)(478600001)(5660300002)(71200400001)(38100700002)(66476007)(122000001)(66946007)(316002)(110136005)(76116006)(26005)(7696005)(33656002)(8676002)(66556008)(8936002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BZam7oz7GWCVoH3n/jvE9F4tEpcr/bpf0JdOmr019oCAb1OI1IX5I/K8pszb?=
 =?us-ascii?Q?Iu/eWQHY0iVfKqf35kZ0H0uUQCWg7c9/KOts7OYQEXxzaqGX+fKcfaeHss6f?=
 =?us-ascii?Q?pt1QxbWbnIJAZ8yu2jgTg6aOGEuIyu/UKzRc8sig7GaLV+dPSasAx7soRqSO?=
 =?us-ascii?Q?ih0hd5juQYZv7cZCft0hjEaFnmz3Il7+LKGkAntDGC/JTBmoO4s2Osjrvr+O?=
 =?us-ascii?Q?AiHtEfmq1rjDh4vazMxLP7xcWqzCKwgmUCXqcP1EZ5tMoaGdfuD/HHqIuTeG?=
 =?us-ascii?Q?gS0pyTwyHyN6wLMyFoqCqitQgsbqMgeiYExzPsm19e6e57sXYmspiCgY1Q12?=
 =?us-ascii?Q?gzWR3PASPzV8XQ8h9Q8umFp6NHBn1vORnXj4BDyzt6eV4hRWqn3HRfxOL5nk?=
 =?us-ascii?Q?vprU3tUBJbRLSgB7VRt2HN4rDmVL7d3+nF4ZThUJM0pSsG/BUHCroCxhHlwb?=
 =?us-ascii?Q?K0cVyLJi1AZWQFLXE6WHxZMJR3iY/EVW+LA+UDggTH5SZUkSB7WxNmF9Hv26?=
 =?us-ascii?Q?JKd2f96TbUJPAP/woWqhQI0L87+Va+jk0+2cIbHOyyWSsyhfkvpgAXNyF3Pj?=
 =?us-ascii?Q?Qus5YiI1a29wJGDlffAfyZCZo5h7m28vVCFv8EYPgvqbFD9nQOZF3fMkCwe3?=
 =?us-ascii?Q?SKwRxTBmft+sPiq1Htr7Z61t3zHzYTg4NAs22VHOuYiSs3yk38Tt1x/08OqF?=
 =?us-ascii?Q?LuGS1tlNITpbfGTYPFUS5Nsx1Cw5Dt1yT75B+RtwGTI/DhLLy9Q2Tnqvw6YD?=
 =?us-ascii?Q?X1ctGvPb4bvxoXUWtVHhvcqU9yT+zhU0awV2f39r8DiUAYj1mH9PRvA1x5gZ?=
 =?us-ascii?Q?I1V/1tV8gKfVlvFDN+xP4RjKH5Miu+NP1pOIyCcpSsJyGYbADr7s9CqG7S2n?=
 =?us-ascii?Q?2PUuE03JiGOtbkUhVRjHYPHR+suRfkQyGMt0bkTUutXtj7PCBS7AAkZlITY9?=
 =?us-ascii?Q?kK+HgJ1mK9RQVVAiMpIzjtPqNpzmuGevEZYJG/PUaFnCYZ7lDAD5QAxLG81o?=
 =?us-ascii?Q?GFNBvZfH0bXv1vCHml02DWJLAYJlRACL8CBvzwiSCf7haKD9Q1iMZEbyziOB?=
 =?us-ascii?Q?e7lmeT333AlnD0nv6slu5HjA/xJ2f4F7vCPNbNhKWSeQWnHhQaVjbJer2TQz?=
 =?us-ascii?Q?mAfr/OeWMoBHZJDd1Qms7LzyZTleSVN7DOdrrkQCa/ZVxiuENsuAX5LW1u6u?=
 =?us-ascii?Q?UYPIJhnDZ7LK6QU8phkUBYXILk5LKvsD6PvB48ZnoLjq4sSvjoXl+iONydPo?=
 =?us-ascii?Q?3MU9709FlsZgPZ3l7rZuAdLCCygKeMqSL/TLnweaeRAiIWuNGnqet0FB2ejh?=
 =?us-ascii?Q?KQL3Su0a/Ry6W5KMv/r67d0+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b404b63-ee05-4123-62d1-08d90485ee7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 05:25:52.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97YFTA7quXmaQPYVDCUSr8da3dmVSxLSft/oQNAhSepbuiNw388Na7OKABLRecZpyI1zJG5jTfA47rM3PR3BXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4273
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port ent=
ries
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Gracefully ignore misconfigured port entries encountered in
> incorrect FPGA images.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index b44523e..660d3b6 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -212,6 +212,7 @@ static int find_dfls_by_default(struct pci_dev *pcide=
v,
>  	int port_num, bar, i, ret =3D 0;
>  	resource_size_t start, len;
>  	void __iomem *base;
> +	int bars =3D 0;
>  	u32 offset;
>  	u64 v;
>=20
> @@ -228,6 +229,7 @@ static int find_dfls_by_default(struct pci_dev *pcide=
v,
>  	if (dfl_feature_is_fme(base)) {
>  		start =3D pci_resource_start(pcidev, 0);
>  		len =3D pci_resource_len(pcidev, 0);
> +		bars |=3D BIT(0);
>=20
>  		dfl_fpga_enum_info_add_dfl(info, start, len);
>=20
> @@ -253,9 +255,21 @@ static int find_dfls_by_default(struct pci_dev *pcid=
ev,
>  			 */
>  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bars & BIT(bar)) {
> +				dev_warn(&pcidev->dev, "skipping bad port
> BAR %d\n", bar);
> +				continue;
> +			}

Will it be a real problem that multiple ports are inside one BAR but differ=
ent offsets?

Hao

> +
>  			start =3D pci_resource_start(pcidev, bar) + offset;
> -			len =3D pci_resource_len(pcidev, bar) - offset;
> +			len =3D pci_resource_len(pcidev, bar);
> +			if (offset >=3D len) {
> +				dev_warn(&pcidev->dev, "bad port
> offset %u >=3D %pa\n",
> +					 offset, &len);
> +				continue;
> +			}
>=20
> +			len -=3D offset;
> +			bars |=3D BIT(bar);
>  			dfl_fpga_enum_info_add_dfl(info, start, len);
>  		}
>  	} else if (dfl_feature_is_port(base)) {
> --
> 1.8.3.1

