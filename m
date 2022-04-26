Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D050EE98
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Apr 2022 04:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiDZCOu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiDZCOt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 22:14:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFBE39688
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 19:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650939104; x=1682475104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HyxFx9a8KYqdSZU5VTe6c86wJGmWTwVS/QuZlz1wIZQ=;
  b=jnPHde+454+LBjcPmsLy/t8y/wRKICi7lSdZtYu4HP6Hhy4UCommYp8y
   lM9ACRgpkr6pkDlwqMGRn2besyJU7Yvj0jBdanLqJQqH0F/JOlBcPExb7
   bSJqfEV+FXlQeWsCfP90eJxChi7q2UQZocQ3M8b+zTbNHJavftQl+c6BT
   1Uui2vLFhjvothJWASsgOn0mnDNmeOm7pBojLcRZ/ERsWNs1+l+/BTMJw
   8BvjIYz9O7z1xF9g+IIJzK8Grgr2j+vJcWe79nT/GzVSAX6APdRCvpoHx
   HUZUwbk8jcOGgdN+BbT/8LC4xWeLPF1pyhcZbErzr2d8jG/7njuCmK6EO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245985214"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="245985214"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="704827571"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 19:11:43 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:11:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 19:11:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 19:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUsryBxZZ35WhoKrjTxBr2PmVdgbw4dFbN22BsANrGyhFJQFH3skpZlo4hNUTW3jITDLkSf1w4EawuKvEMK2opZB5iI3AKlZIPce0uv+394+wYOa4pW2sI6OgpapmAeIi8DoRecD4hq/u8aT7lS6nJmyMXEmtc2dpOPufiWXlJ/257LkZNmhVHVddy1f+k03ku8hjOfnTmce1+s8OH5qioKrHhH8DrRDg6Y3m6VlEVDNxnMWLQ4rz6+pj7lPOVmk1MAU+aKDXhQm+FHWpdca2WKLq8SzyJSfO+gbOpD2OPqJo0G39CSYs1bJK6VxJmISp1YSsx7B9j2uQraxEeKRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fClhS2v3oy7N6o2NobYBe+Mn0A4sJlzlep1tMZCWPs4=;
 b=a+Sta34f9PsrT8RGs7IoV12Zl/ZuYCbSb+c4chAEjTuyF5r3BD4Kj0YMNIfKX7HanIBTsEFhM1rzTsHhiUcckkryIJeZAZ3EgvLPyyRfUOptVRzDGe7mE2oRffcmngsDxWD9P3uwW39TPMwEetuKBLOQ4keLnk/E+M5jnpRb+Rpv/80dbJ3XrbfwQ9iifXWunr09wTzXAUvE66s1JEIgZp8INRL+b8UGisBmF4g9qUoUy82seuNj/Lqd3Gdqotfca3EWBzhDc9hmykEv9GXE8Ofdc6NYeyTQUQ0HgLzvbTA7SjV+9EVZ/SGKQHLMSXzS1DPSGhMS0LWuqSnSpLPNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 02:11:41 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:11:41 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
CC:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v3] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYWRBPXImG6DI64U2SCdiIK9Wflq0BchfA
Date:   Tue, 26 Apr 2022 02:11:41 +0000
Message-ID: <DM6PR11MB3819464398CFB92FD199D0D085FB9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220426014907.570292-1-tianfei.zhang@intel.com>
In-Reply-To: <20220426014907.570292-1-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b17c9377-4b52-42f2-fa78-08da272a1a71
x-ms-traffictypediagnostic: MN2PR11MB4648:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4648A7914A4EC4DE3041F7AD85FB9@MN2PR11MB4648.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dveh/N7/DQDywOSIddOT0pPt0EcPD5v2qsS1v9YqrqrjiDVb2TLTD+4jtKawr5C3z0WIjhZMiHkCVuiJypQp/crP3AV21LlS2LOkc1r2I+ahC7tiOKknKEbVQ+QU/eov0axlvDaPbIX1GQX2d1hWVLpxLEMF3ekfzylgmqHTtAtsear8osCvzbaAqME73ggoJiOiTGKfc0i1UaZYhFyY5hAXX/CCGAmjgSkEb00QKg0qI5cLjobDm7esxZXdbNGv9gxs/6vxyaZ+FLY8SCiGt2haKrEhypM21vJr1zfH5avFYbRiTu4XRsjmtDuHThQ7Ja0FhQR0NRbF2QsC1LRgnXt5pEFl2AixvnmjtM2lknY/qF7tGUIRfRTNZwB7rtuNMP334/jPylLQyBZwqD8bkhOCRs4kuktcAEcIbI7ABO0JRQmtgbFlgatffpybB5pwwmaHnGZbtBCkhIJrQjjnEt3Mebs4/YzwZoggY74mRjrXZ39cKIyksbJJdceL3SWG5Thyb6rX+GQmOQhThlHQoT/gMmLuxDKgj8nTgbpFuw94xVxN9uO167V8anaA/GdCMFwIgChzjAfoH/yet8X0PNKPERaSRVSwvTOKoO6qGZdG78mKLm/1edL9J943uD7QjUIRbGqxR6ln3EA7HJHOnfq0tq0X3+kr4ra5MWlO4Ol4wsmBR9Iuf9OWS7BIdvPderL+cI7WkM+jlGqUBWgmBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66946007)(9686003)(66556008)(8676002)(76116006)(82960400001)(66446008)(66476007)(4326008)(316002)(71200400001)(122000001)(508600001)(53546011)(6506007)(110136005)(86362001)(186003)(38070700005)(38100700002)(83380400001)(7696005)(26005)(33656002)(55016003)(2906002)(52536014)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yo4OfbLQufZcoBzRRC78RF6ZZ0waQDUwjzOdS4PAv6spHJq0jlCQ9NXCOP0s?=
 =?us-ascii?Q?YJQs1bFyQKAs3gdEQfA8YCe0ROCx4G0DS1lUAB4c/q2Doujxl8uSh/EsRtIE?=
 =?us-ascii?Q?3a/W2Kh62aahSsn4D5kEzBhxohSjy+YpDly1Q+7UJElP6txspiVdRl9qwt1W?=
 =?us-ascii?Q?ex5zbBl2UXnG1+xDCOwb69j92oYHP/jqRhJi3rCA1f9u1mvTobmvh56uhsB/?=
 =?us-ascii?Q?zXXgvmD2aC9V1Awdw2IkIJpV/dnzcNEVevw5fQOfRxTKTT8ne6KY0rHZ3a/U?=
 =?us-ascii?Q?vH6rSerQd4ZDy2wS3z5OurknuPhSSqX2WnKtETkgVNGPFKelWscpr9fXhEW4?=
 =?us-ascii?Q?/wrSQkYmYlryTBK3EhQUh0E+1shNKbs+TShJU1651ui7IjKpicIMj2JP2ofy?=
 =?us-ascii?Q?dPt3KKQwCJVzWSWyKdVYqpiZgXZBPYd41pwj70LmLbgOWfj8kT+GLBDha0hW?=
 =?us-ascii?Q?BV9ojOfcRcA232INSTaJcaYBNflz40Iv8vzVc5MO3D7x4HU6f2F7XN0xsB0e?=
 =?us-ascii?Q?rBR7bnolJSvnHWfD+rUWMjv0Lb3Zb6izjFUAGrSKYcwpNCWU5SRv80nFqDK7?=
 =?us-ascii?Q?r3LY+My5OAkfp40F2vCo2cxC3VlzawDSIsoiJZK4oZe/qijWtU2Zvc475jjh?=
 =?us-ascii?Q?rwN7G25MnYKJU/ZU5Tus/3Pu1Ak3NNBB5u+ggkSwxuXNQK3ouf7VNydDJFYp?=
 =?us-ascii?Q?7LcHxi6X0w1N59WRJlcRuzCeyo2gDDn1pMPvUdyfax4MBOKiRzS+963mt+66?=
 =?us-ascii?Q?JPwUy0sYXVkqPQ2LI5aee2Nf4/hZFGLyj1dSqEhWFrHNSy4pL2NoUU3WPhII?=
 =?us-ascii?Q?311M5dESyQIvJKgQdMa/7XJq0KdyviLQUj5pfp8J9BODzOLcgTJO9SuX9FN6?=
 =?us-ascii?Q?WwEgSIWilSJZocyzKbKFX3XVDeAxNSlQ8STCM9y0kxqOfsuj/3ee1HSLgSC5?=
 =?us-ascii?Q?mWGu2ujG94Vl/vFopiwXiiEn0CZAkn/lpux1PsjdUie2hKa0ocJI7+fzn4z2?=
 =?us-ascii?Q?QKdT/OTzUk6BdmfSo3e8ZqBWexLvAdUVEwoePtgKjNge5B7r4BCdY+9VtB35?=
 =?us-ascii?Q?BJ/yjBCFsFx36QufJUZI97gOvA438rlTvQ5/zs4bRsfclXN/x3IEK/8qJ4PQ?=
 =?us-ascii?Q?Frvbk9KhdxD0kgajgWJQZlR0rVS07B3lJV9OZdASe3Svm9/rx83WLDhX22Oa?=
 =?us-ascii?Q?MPqxI72+jmhF1yxeY9DC/kuRZRJ6hl5ZesOHxaXx/eAtXlLKHFYF4qOHN6MG?=
 =?us-ascii?Q?p/soVZLOG01XlJ4a6a5UtTGusGuo22h13nBT9C6SpgwdvdxZnp2auRGJ2V1a?=
 =?us-ascii?Q?/ZpxoZUefNawHYmmapdD7z7slEvT/PKgwLiZyRPDvwjIVWAkX14a3xkRRAJo?=
 =?us-ascii?Q?fNvHDSk5zyh6eB8CimKk1q9NmOlbv0XC0s+L2j09uO1elkh6iJtx/vjvsRpp?=
 =?us-ascii?Q?oUbI0sKqfwC2GZ6ZZX2z/p0SBZkPJA+4NVrxduhbLh9czFJZ9jiJxGKNxqsE?=
 =?us-ascii?Q?mQVvrud9o8g0xSBLHeY9DdVdDZSPo5KuKKcVBsLM1O3Z0MwnQAcCDvoDHkkr?=
 =?us-ascii?Q?kuawqRKua2uXHBknP1fuvhznIzyvjbj06Y7UR51v4Zd0NX+l6/dtKWRPkRTA?=
 =?us-ascii?Q?cyh0raS2yNMUQcIfrSbCVKVbKm0Tc4n1f8UCHimfcFOMunl7EceX26bfrDHA?=
 =?us-ascii?Q?uRG+oEoPIqpUAVDtj5fPEscO760s3fazW66ZXk2PtLLpT2jDQuLHuCy3KsW2?=
 =?us-ascii?Q?0zol1tyIoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17c9377-4b52-42f2-fa78-08da272a1a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:11:41.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XS6ChmpBtNI3a/hGVK8ndTpX1NtYj9RlsgW0WlJWskjgV7fO1CnRk+inlONA6MTte4WBZ/Wr1aqIZpZ/7fdnqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Tuesday, April 26, 2022 9:49 AM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org
> Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>; Zhang, Tianfei
> <tianfei.zhang@intel.com>
> Subject: [PATCH v3] fpga: dfl: Allow Port to be linked to FME's DFL
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are not
> connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack device)=
,
> PORT DFLs are connected to FME DFL directly, so we don't need to search
> PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
> (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for that
> port. If BAR value is invalid, return -EINVAL.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v3: remove dev_dbg and use goto instead of break.
> v2: return -EINVAL if bar number invalid.
> ---
>  drivers/fpga/dfl-pci.c | 10 ++++++++++
>  drivers/fpga/dfl.h     |  1 +
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 86ed9e4223d3..dac45f96c326 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -263,6 +263,15 @@ static int find_dfls_by_default(struct pci_dev *pcid=
ev,
>  			 */
>  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> +				continue;
> +			} else if (bar >=3D PCI_STD_NUM_BARS) {
> +				dev_err(&pcidev->dev, "bad BAR %d for
> port %d\n",
> +					bar, i);
> +				ret =3D -EINVAL;
> +				goto unmap_exit;

will break work here?

> +			}
> +
>  			start =3D pci_resource_start(pcidev, bar) + offset;
>  			len =3D pci_resource_len(pcidev, bar) - offset;
>=20
> @@ -277,6 +286,7 @@ static int find_dfls_by_default(struct pci_dev *pcide=
v,
>  		ret =3D -ENODEV;
>  	}
>=20
> +unmap_exit:
>  	/* release I/O mappings for next step enumeration */
>  	pcim_iounmap_regions(pcidev, BIT(0));
>=20
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 53572c7aced0..e0f0abfbeb8c 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -91,6 +91,7 @@
>  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
>  #define FME_HDR_BITSTREAM_ID	0x60
>  #define FME_HDR_BITSTREAM_MD	0x68
> +#define FME_PORT_OFST_BAR_SKIP	7

Move this line under FME_HDR_PORT_OFST(n),=20
other place looks good to me.


>=20
>  /* FME Fab Capability Register Bitfield */
>  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> version ID */
> --
> 2.26.2

