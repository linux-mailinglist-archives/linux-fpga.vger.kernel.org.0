Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D474C844A
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiCAGpN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCAGpM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:45:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62C36C1C5;
        Mon, 28 Feb 2022 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646117071; x=1677653071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SAx5KS8NabvdNb4UlCttKFXI2FFt+iPd/jDiooT2Bt8=;
  b=PkJguDDV4UvlHDt7aNJVPyOChYn5tjpuva6OFfYd6DPpOvCgSVQPluNq
   h2dbncTv2MCPIcFRZvMsrcqN5HEh2OSm/XEntpE+EjO6U+N82IxdG8CIP
   6Ljh/IphTA89JSTMhcp2C45GyxC/ZyyWevOBlRg3hW+6h66fyFd01vEsW
   5oJ4GBK9Fahff7iUpuVb5xHksUcWIIJqObVCuSP+GeYYZFA8ZmDuAa/RO
   K5boqN04VK2FsSAQLHjC8syuz9hUyJQKUsS6sMI25gFiYoefSaiaTdOiB
   /Q1lH/cCY1FTN1YmccDlbf0gBK3j8w0OFWFOArGQmOa+/UjCgtoRqFLzo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233041081"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="233041081"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="804318196"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2022 22:44:31 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:44:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:44:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 22:44:30 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 22:44:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDHTI3NrZBbWJGo+g53x2cIcrgR2xbWkI4Kbf6w0Dk/8R56vKeJXC9p3zHZPV3rhNI0vujhKtxkPsjSdEin/VFI4oFHzj1MYk0y1xWAQ/Lw5H0VER9NyuxCFlx3P5Dif9J6E3rYNBALghxBS2r48LDMKoREKQWCgAOHxe0lXDQwECVYML3GrfKbi5jnLc6t9bdrI5BIr+5tkY3FiZl5eJ+c9JntdFCLMKolZ0wQvFh8G5otGqy4rNYTJ9kFDviQVcbSDp7YFJq1llP0AFlRkD9qcLbP4vFA935hepmGkKrPPnl4wzAJfp7d8uRleio2KsY56+1MTu5TIynYiv87RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QKFOmdjYjlXohnUx4KI1UFFGARbP00FT7GRvByY+Q0=;
 b=FsLw0E0eKXO+tnTqjiDNITYq8tBgN0HzShr7rxps+FcY07MImjXT7MpyCQEjL+4yB9RELm/zV/Bpu5pfR1LKtEUe3bCDMV1nPa5XQnnEM/3FgZIoX719/wXH2rp7HyEUwMlTqCWvfkUqWy3fEVOpDACKBexmcDdWuryjx2TkAcasT5944n5atC5khWlaKFa31DxsBslkEAwEk1G4lmjEpHC0wDIx8NvZxZUsAS6wRhiI6fblbKFP1aNxwJIGTpKjj8i+lDZsgSsUx2m0jXKInSjtTDxuX0TtN0ahRkAJ+LF90p8/C5qQMF1XQnH0cRBFGuzKVwTsWrYzpviJySickw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 06:44:25 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:44:24 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific bar
 space.
Thread-Topic: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific bar
 space.
Thread-Index: AQHYLTUO5KxgAP1QSU6rEUEpm1RLtqyqEXWw
Date:   Tue, 1 Mar 2022 06:44:24 +0000
Message-ID: <DM6PR11MB38191CD30FC5F6A2AD8F837485029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
 <20220301062123.818687-2-tianfei.zhang@intel.com>
In-Reply-To: <20220301062123.818687-2-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 6768a6da-b0f0-4cef-ceca-08d9fb4eecda
x-ms-traffictypediagnostic: SJ0PR11MB4830:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB48304784A3C6D4B3B7B679AA85029@SJ0PR11MB4830.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /C0hx3WnHTAnd9qYDjeaapzqjwXIHFqelokJdw2DZObixPpleJnm6UVa1uP5xYTB9x3MXMNPbtafk34gvNp8IPpJhhlBuz2CyMB74SdqvlxkO1VCk/Oy0C2cdSe5w4IuBeJn7DUvxfxaAABiuIhV/8hT5dJAFlTxyKP8f92EQZaIjoXu/1rG3TcguNgwlm093FVpgu3yleE48BrTwuC1glJ8E4NLjodnSZJ7SjGOBNsXSfXXSsvKYfAg3o0enKdZbwqFtQlHUehUEMbQzHa7KpPb7t//fusbN4AyBg4AmQAToWwEon8UmtU2ysawPWt7kmpVsJg/+H3pMrgYtXL0TdemC80auG9prvmU1p5yN2JtSHqhJ617GCpVXr6oisob2upkxCItAJ44MpkZ0P5h3SnPfhrMwOk/Rf2Gxok/uaO0iGYn2tuiFGWQEhW62z/dCnDZ8VYvg48gUSf+ZkI8cYuZW03oxIZ/FrnQmr/YcM3xPty6lkLhwMQud5aamrOTzdbMloM5DEpRDY7cQgSJXzVFBfaHHDpaxQ10Upn/NM42UgfnJMl110v2uHPP7Og5J0FXNGMam10FlaIABmTSsSvhaU7uzmAfWr+906e4cHa84XqBIFQYpINi+0nMdh/m7FAGt+NtLLggrbTpFarJporZlTWn6EU2BK8YgNEfVQ1s/9WG5veonLx0BJRR51y60OiPlomTxUru3B58wY146Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(508600001)(53546011)(6506007)(66446008)(52536014)(83380400001)(76116006)(8936002)(7696005)(71200400001)(66946007)(66556008)(8676002)(64756008)(66476007)(4326008)(82960400001)(33656002)(55016003)(54906003)(110136005)(122000001)(9686003)(2906002)(26005)(316002)(186003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EQy7rcxJ0+FWsiH2SGK45UvbRBr2boCGwPEBlMbYvS5MZfARqNTQ7uXCAztm?=
 =?us-ascii?Q?kD49w0Y4zNFb/6RL7a9x5XNEUceXavpbtuf7EgohvfKIZRBRRx7ibdPhYkuS?=
 =?us-ascii?Q?BTjTY1a+q0zGS5W3ZSw4BQcS7hykXchSZ861IwkI1kA3RuNOKuPvz3LAMN0z?=
 =?us-ascii?Q?I9fBYCMrQElI7tP9vyHt7x16qUn0W/O2Do91HQ5kbR2Vpg0x0sOGCdTlpdkM?=
 =?us-ascii?Q?oK1JrVPyYwftUl/m0DIRUgEUhVQevVjEyOgrgCGVQj20qxpN+WzHO0j7qJGO?=
 =?us-ascii?Q?gIcJJSDRaZDMoom8YolclRT4+cX3Nkbba8O8Zz4WjKWo1Am/daYAUHliysBO?=
 =?us-ascii?Q?1g09dmjtaHQs3A6SI027htwrN6IvromomHOcGIJmznNI9SbKSD2drgw8112C?=
 =?us-ascii?Q?oInCEJnF9r0HSdUVKoU3v6GA7JMrMrQvsTXGrnxhHmzx3Vx89zYgNwMPzE0g?=
 =?us-ascii?Q?hrpvmIqJrE5rgDK/2/khc+ZPn3MXnxZGfYkNiz/SGc6X1Xk91ATU/V7oNJlK?=
 =?us-ascii?Q?peYJjJiTGzaIkfvkLo3T78xo5w4AjiCGrlawJ3XMvZs11pjbLEwTU2yQLYPw?=
 =?us-ascii?Q?TwLw3VWIqXRBx3vHB4wOWZ8xXkuIjycWkagXtOnyOvesn0qlrRwXoJh5jGZA?=
 =?us-ascii?Q?TyNwqBSBgIh+9vsMj0NK6bqBNW7givqCE4mAOOfA/sCGRfyTAQycEwrrpjyy?=
 =?us-ascii?Q?nOzT7E4A/iDQLL+th5LZo6yyvWtBKDDddhyZrAK2bTQz28kP2iH+Q/4ixm+g?=
 =?us-ascii?Q?dbC+luM7+ijnrAf7qsleC7v5O9aA0VDohcMCs958pewM7cnhEbwzxLlezWFs?=
 =?us-ascii?Q?tv8YuPnbogvje5VycPbpvdVMLuv0Z+gtlcmggJ1v4ODQ3EiRR+xrI9kX1I4Y?=
 =?us-ascii?Q?CykI5F1TlPfpR3gRMdfpeUL3VROgNUc61HGf7t9M1c3HRaBvpFGGXrkjy429?=
 =?us-ascii?Q?XFCx5eitRi2zYPSa2rDUQDddprQ9CxKwNK2g59ZQs4iXkr4Tw8GL5jTFk9rl?=
 =?us-ascii?Q?395mRBT7DjyJ5ZJB71B+KysvR+qQvlJ1esEarRybW+Mj9FvPG0B38l2HQ52H?=
 =?us-ascii?Q?uAOqnivno+4i9003H1u7BJijwccFQHgCQE58NsqJL0Da4X+0E7vsSahu0SZa?=
 =?us-ascii?Q?75EoAupbtFy2ZSqOq8BgXsvqBH1wK5QjlPZU+Wpfsb8Yr2st1jzgrXY1BpNb?=
 =?us-ascii?Q?j0KVJV2RxgPp0beAG4Qa25H0+UrGsjkGcY5VzvhcrdtJEeX5x+LsbMP9AnsK?=
 =?us-ascii?Q?QW3JZNqNZC2vl8L0pDGDLozPmVGgQHgaeLjOsMS0dPw4k2d2WxKJuSu7YfZj?=
 =?us-ascii?Q?nwDKUpSIue9EqCNEr7/x0oA0mzoZctuK31v9Cr+TeqDuiDarJfv2ubVpo5ej?=
 =?us-ascii?Q?0ORwI5+K5es8S8o+cAl4fgZgdMX4dXFLwP3Q4aLJ7tliyQhje2QDSGlS/YSK?=
 =?us-ascii?Q?N9SoxKHBi0IFFmOri2bj5FgSzvAU2wzU5iBtE9YvOJcTEKOjcVdMFcIlET2s?=
 =?us-ascii?Q?UHGGN3HHzSDgQL+NOGO8Bdydz8v4IBBiKDkxGIsbaR+LLUdadTYwroix3bb3?=
 =?us-ascii?Q?ziXJoX90aniBWRKU++DsiDmezuFWmr7ZZYOxmrMsn+oJZV4fx+4paO+n/dy4?=
 =?us-ascii?Q?Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6768a6da-b0f0-4cef-ceca-08d9fb4eecda
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 06:44:24.8169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7C6Q+CrRy8++9WBUdBxad4cpLOHbPgy8PVW3+1cXn8Rijj8mJ+Q/E7obXD86QPmu0hUEVgyizV8FNa5AAzsGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Tuesday, March 1, 2022 2:21 PM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg
> Cc: linux-kernel@vger.kernel.org; corbet@lwn.net; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Zhang, Tianfei <tianfei.zhang@intel.co=
m>
> Subject: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific bar s=
pace.
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> In OFS, there is a Port device for each PR slot, like Port
> control, Port user clock control and Port errors, those feature
> devices are linked with DFL. The DFL of Port device was located
> in PCIe Bar 0 MMIO space by default, but it also can put into any

There is not default BAR for Port. In OFS implementation it could
be 0, but not default value for other implementation.

> PCIe Bar space. If the BarID (3bits field) in PORTn_OFFSET register
> set to invalid means that DFL of Port device is located in the Bar 0
> by default, in this case, it don't need add the Bar 0 into dfl list
> twice.

So why not just use existing method (e.g. BAR0 + offset) to locate
DFL of port?

The title is confusing too, PORTs still have its BAR location/space.

Hao

>=20
> ---
> v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 6 ++++++
>  drivers/fpga/dfl.h     | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4d68719e608f..33545c999c06 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -258,6 +258,12 @@ static int find_dfls_by_default(struct pci_dev *pcid=
ev,
>  			 */
>  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar >=3D FME_HDR_NO_PORT_BAR) {
> +				dev_dbg(&pcidev->dev, "skipping port without
> specific BAR space %d\n",
> +					bar);
> +				continue;
> +			}
> +
>  			start =3D pci_resource_start(pcidev, bar) + offset;
>  			len =3D pci_resource_len(pcidev, bar) - offset;
>=20
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 53572c7aced0..1fd493e82dd8 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -91,6 +91,7 @@
>  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
>  #define FME_HDR_BITSTREAM_ID	0x60
>  #define FME_HDR_BITSTREAM_MD	0x68
> +#define FME_HDR_NO_PORT_BAR	7
>=20
>  /* FME Fab Capability Register Bitfield */
>  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> version ID */
> --
> 2.26.2

