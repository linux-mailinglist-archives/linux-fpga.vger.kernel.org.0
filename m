Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030C23B57F1
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 05:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhF1DwP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 27 Jun 2021 23:52:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:57848 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhF1DwP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 27 Jun 2021 23:52:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="207700739"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="207700739"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 20:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="407571887"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2021 20:49:49 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 27 Jun 2021 20:49:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 27 Jun 2021 20:49:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 27 Jun 2021 20:49:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REkiFnZtQi1nu6UPVomf6dPov9EyriPMbQzgvdRMxwVj9BEXiyyuH+67xNZAIiUUxGFBfgeCkJDvab/YmNOqg1Vv52F9p41terd3J7gOw0K+arK1vrxp7bOypcLIrVcPBLRPvM0jUGHk40Kl1KLJnVdLO19f+j7poLpDubnhJ1jxJu7E7K/vtNf1gNsyzFoQXB+w0ImBX9Qo7rZQ0h98eCu8qQc2U32hpcVJ+wRNXQlYSe+042Y0w+GmEdjo2xbtta5fVTGchw9Im5IdnAn0pt9xMegMCUv7hnp+CtcB3yjpO77Gj0AdJxlfbRGNAUlE3YFqfEUgjTvetyQ9VMeZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id1Zg2XOYJM5dLaNhezanJQzG9INhxmeJSdLe3lTEYc=;
 b=PWdTXulGvJQ+qJN23P8qnpjUSO6q7zCiFip8p7c8YBZw9ZcRZP9dDcDlrDQh6u6io1LdLvC/AHuHzP878Di/9jfP0wOBi0dt+QpiqxwcNNFzqbCfDgfsKlKj+ltBTTw2LRr3wnuYyb3EFoZyEkz5TglP/D8wGLO4JSQxmBbzmPXctFRPIPwXLIjHExZgjZYAsJy/zbKzevvpKT2YwiU5/0uUI7dCzkpR0fjy/XQVNilMm2f8Ft1IaCvs+ecl6fWqkIqE/31J6kqn0ygoIry8ZvK5ZInVnMWMmM+4/KvojGUINFTNOicPXNapsINgh7pgaN2/bNpdJ5gkUws4K9OMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id1Zg2XOYJM5dLaNhezanJQzG9INhxmeJSdLe3lTEYc=;
 b=zjMGyZSlXg3XMCghhGkFcGxkaQAyFJ9/0UuTRZZUAn6qYdPPdXCXxkpLBSTTRHpo9pyjvpQJI2Rs02leMuO6KrtuoH24LWh6WqYb0R/t42zxUi+UvZFCvFrFYYkAq89kAlW3rdoUfoQ8nLDzVyyqDta4ikXLVy+HQFuJrD7j2pg=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4121.namprd11.prod.outlook.com (2603:10b6:5:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 03:49:47 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 03:49:47 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        "Gong, Richard" <richard.gong@intel.com>
Subject: RE: [PATCH v8 1/3] fpga: mgr: Use standard dev_release for class
 driver
Thread-Topic: [PATCH v8 1/3] fpga: mgr: Use standard dev_release for class
 driver
Thread-Index: AQHXaTsojFIawaKfq0+UpBwJgjD9FKsozLcQ
Date:   Mon, 28 Jun 2021 03:49:46 +0000
Message-ID: <DM6PR11MB3819FCE3043C3F1D101DCA2D85039@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210624205355.517687-1-russell.h.weight@intel.com>
 <20210624205355.517687-2-russell.h.weight@intel.com>
In-Reply-To: <20210624205355.517687-2-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e8b54d8-ecd5-4e7a-3900-08d939e7c5e8
x-ms-traffictypediagnostic: DM6PR11MB4121:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4121465B2BA6B5C072D8D25B85039@DM6PR11MB4121.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDj0swk0V4SFW8YOFDMjNCJ/DUlCKOeVuuwhR/lgOZiQtQqMhe+LYFPoSUOoDtP9JbOBJacjJ/8Zj12Pk2yW58FKQWtsnQwzyLyZgmyY1T8rTf6MPisDW9CqsGVzaW7StReycGB4W7utdQn/6xZRWw6AjDUqA3AFOBNjXTVhPHvfnQ5USIJuvEtufjnW9e7tqZi3uRsorNTkmAwVxmYX4Te5XhKCmdlQxc5rwpThVt907KRsqwnNvoWeRjVfmxFz9slTRG/0q0Iwl7vE0kA5ufc+CEPMj3zgITyBpeNoEfATKl5zQjVhdYbEb6jN9HMtvIDpU0NmJljSwpVivMe/D500udEMaCmZByIIFB4hJM6e0Ygnb6XCKAAY0wClX7ckl5oC9FpVImXSHIqjtDC7Ml4f3/LQeFxfKaunq038MwEW6sc9JwlJdcIbTNPlZYzMtZma67QQvzEZsRFqpCZpKYZXxRnUftsuh/RYQ6zcZ4Kp0ci2hm2P/XWKXdUyfbfPwPcc68Z1qV3exB7wTlB6gK/tuCLpJREoGF8Ysz/+ynGGj3PgHr7CXQAwzJu3sTeuiZhEcZGDL0zJCfwWguivfzanaQN42Oov2ZKU6qQn94M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(366004)(396003)(2906002)(26005)(83380400001)(71200400001)(64756008)(66476007)(66556008)(52536014)(186003)(76116006)(66946007)(66446008)(6506007)(53546011)(8936002)(107886003)(7696005)(30864003)(122000001)(110136005)(33656002)(316002)(4326008)(54906003)(5660300002)(9686003)(86362001)(478600001)(55016002)(38100700002)(8676002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QTsLjjCe4hLa3myfy5ZlxXNxg0jROth4nPdQic6PvXbq+AWY57DyabS3H2dc?=
 =?us-ascii?Q?R5nPBZQ8ytO0oOT4M7L2UkGqdb4YyFXI+M3nSVZkf5y3xj8StnGZfpRJ76z7?=
 =?us-ascii?Q?dUL8sCeST3MtePanYEgPdM+ZGi2DiyxZdhSCi+/Iv8168gssAMIT1nS0eRj4?=
 =?us-ascii?Q?GVsvVig4C1Ef1OJirsu76WYSXQfWGV4Hftc5ehUSFncRAsDe+CFlZCwlRo4/?=
 =?us-ascii?Q?d3WYCDB11We2IoMowxt6r/OC81r0KJxXd31IAnQTZ1GK1G3pz9JD5RQ6677J?=
 =?us-ascii?Q?TyIa000/wuIP7djnV/xR+UcE7sRKKCCnTM5pm66aSIpKy9/X2SepIE3xOiM/?=
 =?us-ascii?Q?WBHEQ1wYo58Y/bfeF+ZvDKuQC5bq3GarCgjBJ4ThwlnGeaamxUOjCRyKHjd6?=
 =?us-ascii?Q?RrQYCL01Dc7H+40dGA0U34dQn+gWYayOSP0bv1uGxf1twoNaTyEjqrDqe5P8?=
 =?us-ascii?Q?E/M8AyfnFydAvv4tStXjQatdpSytaFatQGrJLOq+ZXda1b0KXYNuC4foGYGu?=
 =?us-ascii?Q?F1SLDPmSLV/U4Rltg2q8+UM3BeAuQ2GWFQ3Jh5xi1Er6HMZKRgEeQb5FgOir?=
 =?us-ascii?Q?cMAtAlrMg3onsT7ZNkt8fh6WgneApSxliSJxm2sdpDZaTJRit2LluKE/sguJ?=
 =?us-ascii?Q?DEKXtor0o5qVfOeK/0/yUp6rmdtX4l7kpGbI+9fK+MIxu8RGhAKPONcti1eB?=
 =?us-ascii?Q?yx0a1tAGMl/sKaMZuCSKKSxvYb30FU9oIwOc+8Itgl62x9O06gDGmpjD5gpy?=
 =?us-ascii?Q?cQFqAL2AfLW+xOsagFfIv9RVPLpkA1e9Z2RSoWfmlwzMOjwmkPZyoznBK/0L?=
 =?us-ascii?Q?cIyFYoMGdgFsM0lduEu79ccKhaDGIq2eCz0qbRGFn7ufbr85K/wlvJSVc9ff?=
 =?us-ascii?Q?OmFtBo7gHybMZ24Ilea35lnu3B8EGhVoLPLcbJd13lKkKLpTtMNBZK6OlAgp?=
 =?us-ascii?Q?vOmWMfUP+fEJtJjTOebYqqnsTZG9/ZTwzXfemTbXYh0y1PQEK4k2dNj7kFb9?=
 =?us-ascii?Q?BxtoXqvMq0NVRO6X4KNeec+QbLutaHAa3eyc2/P3kLTQDZ91ElO2vUph8N4H?=
 =?us-ascii?Q?WO25ZXDNpo9Ux6symKGc2xhARaykzYMkGxlOIRAQsFvr12vWuiejvwJwjV7T?=
 =?us-ascii?Q?5riiqu/A19SRLh03xEBHWuMsO5hnS32yFVWbQJ/p30iClNdqb7fYAy2+aTa7?=
 =?us-ascii?Q?xBaHBLI8ljA5mQTxXSI9c9YiTEKTinpQfVcxlpTRIWHOJYIa1G4M0QO4y5b6?=
 =?us-ascii?Q?8YVe/ME6IX0s3C0ze7sawiYWcQpPIHcSKK7KZM2oI61NqzEHoffC5o+603Lb?=
 =?us-ascii?Q?zBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8b54d8-ecd5-4e7a-3900-08d939e7c5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 03:49:46.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXHB5I9ffPEtLSQHz6AXJol4tyzgBGvwPEDdHuk9h+38HUIOP/iEJ5wfkIL7oC1rYOaiGCy636VIUXeZEmSsRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4121
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Weight, Russell H <russell.h.weight@intel.com>
> Sent: Friday, June 25, 2021 4:54 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
> <matthew.gerlach@intel.com>; Gong, Richard <richard.gong@intel.com>;
> Weight, Russell H <russell.h.weight@intel.com>
> Subject: [PATCH v8 1/3] fpga: mgr: Use standard dev_release for class dri=
ver
>=20
> The FPGA manager class driver data structure is being treated as a
> managed resource instead of using the standard dev_release call-back
> function to release the class data structure. This change removes
> the managed resource code for the freeing of the class data structure
> and combines the create() and register() functions into a single
> register() or register_simple() function.
>=20

Maybe register() and register_full() is better. it keeps the most used
function name the same (and shorter than register_simple()). Just
my 2 cents. Let's wait for review comments from Moritz to decide. : )

Thanks
Hao

> The register() function accepts an info data structure to provide
> flexibility in passing optional parameters. The register_simple()
> function supports the current parameter list for users that don't
> require the use of optional parameters.
>=20
> The devm_fpga_mgr_register() function is retained, and the
> devm_fpga_mgr_register_simple() function is added.
>=20
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v8:
>   - Added reviewed-by tag.
>   - Updated Documentation/driver-api/fpga/fpga-mgr.rst documentation.
> v7:
>   - Update the commit message to describe the new parameters for the
>     *fpga_mgr_register() functions and to mention the
>     *fpga_mgr_register_simple() functions.
>   - Fix function prototypes in header file to rename dev to parent.
>   - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>   - Some cleanup of comments.
>   - Update function defintions/prototypes to apply const to the new info
>     parameter.
> v6:
>   - Moved FPGA manager optional parameters out of the ops structure and
>     back into the FPGA manager structure.
>   - Changed fpga_mgr_register()/devm_fpga_mgr_register() parameters to
>     accept an info data structure to provide flexibility in passing optio=
nal
>     parameters.
>   - Added fpga_mgr_register_simple()/devm_fpga_mgr_register_simple()
>     functions to support current parameters for users that don't require
>     the use of optional parameters.
> v5:
>   - Rebased on top of recently accepted patches.
>   - Removed compat_id from the fpga_mgr_register() parameter list
>     and added it to the fpga_manager_ops structure. This also required
>     dynamically allocating the dfl-fme-ops structure in order to add
>     the appropriate compat_id.
> v4:
>   - Added the compat_id parameter to fpga_mgr_register() and
>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>     the device_register() call.
> v3:
>   - Cleaned up comment header for fpga_mgr_register()
>   - Fix error return on ida_simple_get() failure
> v2:
>   - Restored devm_fpga_mgr_register() functionality, adapted for the comb=
ined
>     create/register functionality.
>   - All previous callers of devm_fpga_mgr_register() will continue to cal=
l
>     devm_fpga_mgr_register().
>   - replaced unnecessary ternary operators in return statements with stan=
dard
>     if conditions.
> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst |  39 ++--
>  drivers/fpga/altera-cvp.c                  |  12 +-
>  drivers/fpga/altera-pr-ip-core.c           |   8 +-
>  drivers/fpga/altera-ps-spi.c               |   9 +-
>  drivers/fpga/dfl-fme-mgr.c                 |  22 +--
>  drivers/fpga/fpga-mgr.c                    | 214 +++++++++------------
>  drivers/fpga/ice40-spi.c                   |   9 +-
>  drivers/fpga/machxo2-spi.c                 |  10 +-
>  drivers/fpga/socfpga-a10.c                 |  16 +-
>  drivers/fpga/socfpga.c                     |   9 +-
>  drivers/fpga/stratix10-soc.c               |  16 +-
>  drivers/fpga/ts73xx-fpga.c                 |   9 +-
>  drivers/fpga/xilinx-spi.c                  |  11 +-
>  drivers/fpga/zynq-fpga.c                   |  16 +-
>  drivers/fpga/zynqmp-fpga.c                 |   9 +-
>  include/linux/fpga/fpga-mgr.h              |  62 ++++--
>  16 files changed, 204 insertions(+), 267 deletions(-)
>=20
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst
> b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 4d926b452cb3..fbb7f07cae9f 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -24,7 +24,8 @@ How to support a new FPGA device
>  --------------------------------
>=20
>  To add another FPGA manager, write a driver that implements a set of ops=
.  The
> -probe function calls fpga_mgr_register(), such as::
> +probe function calls devm_fpga_mgr_register() or
> +devm_fpga_mgr_register_simple(), such as::
>=20
>  	static const struct fpga_manager_ops socfpga_fpga_ops =3D {
>  		.write_init =3D socfpga_fpga_ops_configure_init,
> @@ -49,23 +50,9 @@ probe function calls fpga_mgr_register(), such as::
>  		 * them in priv
>  		 */
>=20
> -		mgr =3D devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA
> Manager",
> -					   &socfpga_fpga_ops, priv);
> -		if (!mgr)
> -			return -ENOMEM;
> -
> -		platform_set_drvdata(pdev, mgr);
> -
> -		return fpga_mgr_register(mgr);
> -	}
> -
> -	static int socfpga_fpga_remove(struct platform_device *pdev)
> -	{
> -		struct fpga_manager *mgr =3D platform_get_drvdata(pdev);
> -
> -		fpga_mgr_unregister(mgr);
> -
> -		return 0;
> +		mgr =3D devm_fpga_mgr_register_simple(dev, "Altera SOCFPGA
> FPGA Manager",
> +						    &socfpga_fpga_ops, priv);
> +		return PTR_ERR_OR_ZERO(mgr);
>  	}
>=20
>=20
> @@ -104,8 +91,10 @@ API for implementing a new FPGA Manager driver
>  * ``fpga_mgr_states`` -  Values for :c:expr:`fpga_manager->state`.
>  * struct fpga_manager -  the FPGA manager struct
>  * struct fpga_manager_ops -  Low level FPGA manager driver ops
> -* devm_fpga_mgr_create() -  Allocate and init a manager struct
> -* fpga_mgr_register() -  Register an FPGA manager
> +* fpga_mgr_register() -  Create and register an FPGA manager
> +* fpga_mgr_register_simple() -  Create and register an FPGA manager
> +* devm_fpga_mgr_register() -  Create and register an FPGA manager
> +* devm_fpga_mgr_register_simple() -  Create and register an FPGA manager
>  * fpga_mgr_unregister() -  Unregister an FPGA manager
>=20
>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
> @@ -118,10 +107,16 @@ API for implementing a new FPGA Manager driver
>     :functions: fpga_manager_ops
>=20
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: devm_fpga_mgr_create
> +   :functions: fpga_mgr_register
>=20
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
> -   :functions: fpga_mgr_register
> +   :functions: fpga_mgr_register_simple
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: devm_fpga_mgr_register
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: devm_fpga_mgr_register_simple
>=20
>  .. kernel-doc:: drivers/fpga/fpga-mgr.c
>     :functions: fpga_mgr_unregister
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index ccf4546eff29..ddf2ffe3f138 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
>  		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
>=20
> -	mgr =3D devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> -				   &altera_cvp_ops, conf);
> -	if (!mgr) {
> -		ret =3D -ENOMEM;
> +	mgr =3D fpga_mgr_register_simple(&pdev->dev, conf->mgr_name,
> +				       &altera_cvp_ops, conf);
> +	if (IS_ERR(mgr)) {
> +		ret =3D PTR_ERR(mgr);
>  		goto err_unmap;
>  	}
>=20
>  	pci_set_drvdata(pdev, mgr);
>=20
> -	ret =3D fpga_mgr_register(mgr);
> -	if (ret)
> -		goto err_unmap;
> -
>  	return 0;
>=20
>  err_unmap:
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip=
-core.c
> index dfdf21ed34c4..e0baf3392b67 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -191,11 +191,9 @@ int alt_pr_register(struct device *dev, void __iomem
> *reg_base)
>  		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
>  		(int)(val & ALT_PR_CSR_PR_START));
>=20
> -	mgr =3D devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(dev, dev_name(dev),
> +					    &alt_pr_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_register);
>=20
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 23bfd4d1ad0f..f544de2a9f6b 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -302,12 +302,9 @@ static int altera_ps_probe(struct spi_device *spi)
>  	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
>  		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
>=20
> -	mgr =3D devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> -				   &altera_ps_ops, conf);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(&spi->dev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(&spi->dev, conf->mgr_name,
> +					    &altera_ps_ops, conf);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  static const struct spi_device_id altera_ps_spi_ids[] =3D {
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index d5861d13b306..20b1cf3d957f 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -282,7 +282,7 @@ static void fme_mgr_get_compat_id(void __iomem
> *fme_pr,
>  static int fme_mgr_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_mgr_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> -	struct fpga_compat_id *compat_id;
> +	struct fpga_manager_info info =3D { 0 };
>  	struct device *dev =3D &pdev->dev;
>  	struct fme_mgr_priv *priv;
>  	struct fpga_manager *mgr;
> @@ -302,20 +302,16 @@ static int fme_mgr_probe(struct platform_device
> *pdev)
>  			return PTR_ERR(priv->ioaddr);
>  	}
>=20
> -	compat_id =3D devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
> -	if (!compat_id)
> +	info.name =3D "DFL FME FPGA Manager";
> +	info.mops =3D &fme_mgr_ops;
> +	info.priv =3D priv;
> +	info.compat_id =3D devm_kzalloc(dev, sizeof(*info.compat_id),
> GFP_KERNEL);
> +	if (!info.compat_id)
>  		return -ENOMEM;
>=20
> -	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> -
> -	mgr =3D devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> -				   &fme_mgr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	mgr->compat_id =3D compat_id;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	fme_mgr_get_compat_id(priv->ioaddr, info.compat_id);
> +	mgr =3D devm_fpga_mgr_register(dev, &info);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  static struct platform_driver fme_mgr_driver =3D {
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index ecb4c3c795fa..6bd65a1b84fb 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -550,21 +550,19 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>=20
>  /**
> - * fpga_mgr_create - create and initialize an FPGA manager struct
> + * fpga_mgr_register - create and register an FPGA Manager device
>   * @parent:	fpga manager device from pdev
> - * @name:	fpga manager name
> - * @mops:	pointer to structure of fpga manager ops
> - * @priv:	fpga manager private data
> + * @info:	parameters for fpga manager
>   *
> - * The caller of this function is responsible for freeing the struct wit=
h
> - * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended=
.
> + * The caller of this function is responsible for calling fpga_mgr_unreg=
ister().
> + * Using devm_fpga_mgr_register() instead is recommended.
>   *
> - * Return: pointer to struct fpga_manager or NULL
> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>   */
> -struct fpga_manager *fpga_mgr_create(struct device *parent, const char
> *name,
> -				     const struct fpga_manager_ops *mops,
> -				     void *priv)
> +struct fpga_manager *
> +fpga_mgr_register(struct device *parent, const struct fpga_manager_info
> *info)
>  {
> +	const struct fpga_manager_ops *mops =3D info->mops;
>  	struct fpga_manager *mgr;
>  	int id, ret;
>=20
> @@ -572,29 +570,31 @@ struct fpga_manager *fpga_mgr_create(struct device
> *parent, const char *name,
>  	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>  	    (mops->write && mops->write_sg)) {
>  		dev_err(parent, "Attempt to register without
> fpga_manager_ops\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>=20
> -	if (!name || !strlen(name)) {
> +	if (!info->name || !strlen(info->name)) {
>  		dev_err(parent, "Attempt to register with no name!\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>=20
>  	mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
>  	if (!mgr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>=20
>  	id =3D ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> +	if (id < 0) {
> +		ret =3D id;
>  		goto error_kfree;
> +	}
>=20
>  	mutex_init(&mgr->ref_mutex);
>=20
> -	mgr->name =3D name;
> -	mgr->mops =3D mops;
> -	mgr->priv =3D priv;
> +	mgr->name =3D info->name;
> +	mgr->mops =3D info->mops;
> +	mgr->priv =3D info->priv;
> +	mgr->compat_id =3D info->compat_id;
>=20
> -	device_initialize(&mgr->dev);
>  	mgr->dev.class =3D fpga_mgr_class;
>  	mgr->dev.groups =3D mops->groups;
>  	mgr->dev.parent =3D parent;
> @@ -605,6 +605,19 @@ struct fpga_manager *fpga_mgr_create(struct device
> *parent, const char *name,
>  	if (ret)
>  		goto error_device;
>=20
> +	/*
> +	 * Initialize framework state by requesting low level driver read state
> +	 * from device.  FPGA may be in reset mode or may have been
> programmed
> +	 * by bootloader or EEPROM.
> +	 */
> +	mgr->state =3D mgr->mops->state(mgr);
> +
> +	ret =3D device_register(&mgr->dev);
> +	if (ret) {
> +		put_device(&mgr->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return mgr;
>=20
>  error_device:
> @@ -612,98 +625,38 @@ struct fpga_manager *fpga_mgr_create(struct device
> *parent, const char *name,
>  error_kfree:
>  	kfree(mgr);
>=20
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(fpga_mgr_create);
> -
> -/**
> - * fpga_mgr_free - free an FPGA manager created with fpga_mgr_create()
> - * @mgr:	fpga manager struct
> - */
> -void fpga_mgr_free(struct fpga_manager *mgr)
> -{
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -	kfree(mgr);
> -}
> -EXPORT_SYMBOL_GPL(fpga_mgr_free);
> -
> -static void devm_fpga_mgr_release(struct device *dev, void *res)
> -{
> -	struct fpga_mgr_devres *dr =3D res;
> -
> -	fpga_mgr_free(dr->mgr);
> +	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(fpga_mgr_register);
>=20
>  /**
> - * devm_fpga_mgr_create - create and initialize a managed FPGA manager
> struct
> + * fpga_mgr_register_simple - create and register an FPGA Manager device
>   * @parent:	fpga manager device from pdev
>   * @name:	fpga manager name
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
>   *
> - * This function is intended for use in an FPGA manager driver's probe f=
unction.
> - * After the manager driver creates the manager struct with
> - * devm_fpga_mgr_create(), it should register it with fpga_mgr_register(=
).  The
> - * manager driver's remove function should call fpga_mgr_unregister().  =
The
> - * manager struct allocated with this function will be freed automatical=
ly on
> - * driver detach.  This includes the case of a probe function returning =
error
> - * before calling fpga_mgr_register(), the struct will still get cleaned=
 up.
> + * The caller of this function is responsible for calling fpga_mgr_unreg=
ister().
> + * Using devm_fpga_mgr_register_simple() instead is recommended. This
> simple
> + * version of the register function should be sufficient for most users.=
 The
> + * fpga_mgr_register() function is available for users that need to pass
> + * additional, optional parameters.
>   *
> - * Return: pointer to struct fpga_manager or NULL
> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>   */
> -struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const
> char *name,
> -					  const struct fpga_manager_ops
> *mops,
> -					  void *priv)
> +struct fpga_manager *
> +fpga_mgr_register_simple(struct device *parent, const char *name,
> +			 const struct fpga_manager_ops *mops, void *priv)
>  {
> -	struct fpga_mgr_devres *dr;
> +	struct fpga_manager_info info =3D { 0 };
>=20
> -	dr =3D devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
> -	if (!dr)
> -		return NULL;
> -
> -	dr->mgr =3D fpga_mgr_create(parent, name, mops, priv);
> -	if (!dr->mgr) {
> -		devres_free(dr);
> -		return NULL;
> -	}
> -
> -	devres_add(parent, dr);
> +	info.name =3D name;
> +	info.mops =3D mops;
> +	info.priv =3D priv;
>=20
> -	return dr->mgr;
> +	return fpga_mgr_register(parent, &info);
>  }
> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
> -
> -/**
> - * fpga_mgr_register - register an FPGA manager
> - * @mgr: fpga manager struct
> - *
> - * Return: 0 on success, negative error code otherwise.
> - */
> -int fpga_mgr_register(struct fpga_manager *mgr)
> -{
> -	int ret;
> -
> -	/*
> -	 * Initialize framework state by requesting low level driver read state
> -	 * from device.  FPGA may be in reset mode or may have been
> programmed
> -	 * by bootloader or EEPROM.
> -	 */
> -	mgr->state =3D mgr->mops->state(mgr);
> -
> -	ret =3D device_add(&mgr->dev);
> -	if (ret)
> -		goto error_device;
> -
> -	dev_info(&mgr->dev, "%s registered\n", mgr->name);
> -
> -	return 0;
> -
> -error_device:
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(fpga_mgr_register);
> +EXPORT_SYMBOL_GPL(fpga_mgr_register_simple);
>=20
>  /**
>   * fpga_mgr_unregister - unregister an FPGA manager
> @@ -726,14 +679,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>=20
> -static int fpga_mgr_devres_match(struct device *dev, void *res,
> -				 void *match_data)
> -{
> -	struct fpga_mgr_devres *dr =3D res;
> -
> -	return match_data =3D=3D dr->mgr;
> -}
> -
>  static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>  {
>  	struct fpga_mgr_devres *dr =3D res;
> @@ -743,44 +688,67 @@ static void devm_fpga_mgr_unregister(struct device
> *dev, void *res)
>=20
>  /**
>   * devm_fpga_mgr_register - resource managed variant of fpga_mgr_registe=
r()
> - * @dev: managing device for this FPGA manager
> - * @mgr: fpga manager struct
> + * @parent:	fpga manager device from pdev
> + * @info:	parameters for fpga manager
>   *
>   * This is the devres variant of fpga_mgr_register() for which the unreg=
ister
>   * function will be called automatically when the managing device is det=
ached.
>   */
> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> +struct fpga_manager *
> +devm_fpga_mgr_register(struct device *parent, const struct
> fpga_manager_info *info)
>  {
>  	struct fpga_mgr_devres *dr;
> -	int ret;
> -
> -	/*
> -	 * Make sure that the struct fpga_manager * that is passed in is
> -	 * managed itself.
> -	 */
> -	if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
> -				 fpga_mgr_devres_match, mgr)))
> -		return -EINVAL;
> +	struct fpga_manager *mgr;
>=20
>  	dr =3D devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
>  	if (!dr)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>=20
> -	ret =3D fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr =3D fpga_mgr_register(parent, info);
> +	if (IS_ERR(mgr)) {
>  		devres_free(dr);
> -		return ret;
> +		return mgr;
>  	}
>=20
>  	dr->mgr =3D mgr;
> -	devres_add(dev, dr);
> +	devres_add(parent, dr);
>=20
> -	return 0;
> +	return mgr;
>  }
>  EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>=20
> +/**
> + * devm_fpga_mgr_register_simple - resource managed variant of
> + *				   fpga_mgr_register_simple()
> + * @parent:	fpga manager device from pdev
> + * @name:	fpga manager name
> + * @mops:	pointer to structure of fpga manager ops
> + * @priv:	fpga manager private data
> + *
> + * This is the devres variant of fpga_mgr_register_simple() for which th=
e
> + * unregister function will be called automatically when the managing
> + * device is detached.
> + */
> +struct fpga_manager *
> +devm_fpga_mgr_register_simple(struct device *parent, const char *name,
> +			      const struct fpga_manager_ops *mops, void *priv)
> +{
> +	struct fpga_manager_info info =3D { 0 };
> +
> +	info.name =3D name;
> +	info.mops =3D mops;
> +	info.priv =3D priv;
> +
> +	return devm_fpga_mgr_register(parent, &info);
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_simple);
> +
>  static void fpga_mgr_dev_release(struct device *dev)
>  {
> +	struct fpga_manager *mgr =3D to_fpga_manager(dev);
> +
> +	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> +	kfree(mgr);
>  }
>=20
>  static int __init fpga_mgr_class_init(void)
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 69dec5af23c3..448eb6f4e509 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -178,12 +178,9 @@ static int ice40_fpga_probe(struct spi_device *spi)
>  		return ret;
>  	}
>=20
> -	mgr =3D devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
> -				   &ice40_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(dev, "Lattice iCE40 FPGA
> Manager",
> +					    &ice40_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  static const struct of_device_id ice40_fpga_of_match[] =3D {
> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> index 114a64d2b7a4..77be11155402 100644
> --- a/drivers/fpga/machxo2-spi.c
> +++ b/drivers/fpga/machxo2-spi.c
> @@ -366,12 +366,10 @@ static int machxo2_spi_probe(struct spi_device *spi=
)
>  		return -EINVAL;
>  	}
>=20
> -	mgr =3D devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA
> Manager",
> -				   &machxo2_ops, spi);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(dev,
> +					    "Lattice MachXO2 SPI FPGA
> Manager",
> +					    &machxo2_ops, spi);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  static const struct of_device_id of_match[] =3D {
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index 573d88bdf730..5ffefaa3eb07 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -508,19 +508,15 @@ static int socfpga_a10_fpga_probe(struct
> platform_device *pdev)
>  		return -EBUSY;
>  	}
>=20
> -	mgr =3D devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
> -				   &socfpga_a10_fpga_mgr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, mgr);
> -
> -	ret =3D fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr =3D fpga_mgr_register_simple(dev, "SoCFPGA Arria10 FPGA Manager",
> +				       &socfpga_a10_fpga_mgr_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		clk_disable_unprepare(priv->clk);
> -		return ret;
> +		return PTR_ERR(mgr);
>  	}
>=20
> +	platform_set_drvdata(pdev, mgr);
> +
>  	return 0;
>  }
>=20
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index 1f467173fc1f..9280db4364d4 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -571,12 +571,9 @@ static int socfpga_fpga_probe(struct platform_device
> *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	mgr =3D devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> -				   &socfpga_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(dev, "Altera SOCFPGA FPGA
> Manager",
> +					    &socfpga_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  #ifdef CONFIG_OF
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index a2cea500f7cc..fb84d88d4ce9 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -425,18 +425,11 @@ static int s10_probe(struct platform_device *pdev)
>=20
>  	init_completion(&priv->status_return_completion);
>=20
> -	mgr =3D fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
> -			      &s10_ops, priv);
> -	if (!mgr) {
> -		dev_err(dev, "unable to create FPGA manager\n");
> -		ret =3D -ENOMEM;
> -		goto probe_err;
> -	}
> -
> -	ret =3D fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr =3D fpga_mgr_register_simple(dev, "Stratix10 SOC FPGA Manager",
> +				       &s10_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		dev_err(dev, "unable to register FPGA manager\n");
> -		fpga_mgr_free(mgr);
> +		ret =3D PTR_ERR(mgr);
>  		goto probe_err;
>  	}
>=20
> @@ -454,7 +447,6 @@ static int s10_remove(struct platform_device *pdev)
>  	struct s10_priv *priv =3D mgr->priv;
>=20
>  	fpga_mgr_unregister(mgr);
> -	fpga_mgr_free(mgr);
>  	stratix10_svc_free_channel(priv->chan);
>=20
>  	return 0;
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> index 101f016c6ed8..009d5cfa1074 100644
> --- a/drivers/fpga/ts73xx-fpga.c
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -122,12 +122,9 @@ static int ts73xx_fpga_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(priv->io_base))
>  		return PTR_ERR(priv->io_base);
>=20
> -	mgr =3D devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
> -				   &ts73xx_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(kdev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(kdev, "TS-73xx FPGA Manager",
> +					    &ts73xx_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  static struct platform_driver ts73xx_fpga_driver =3D {
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index fee4d0abf6bf..6f568a757cf2 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -247,13 +247,10 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
>  				     "Failed to get DONE gpio\n");
>=20
> -	mgr =3D devm_fpga_mgr_create(&spi->dev,
> -				   "Xilinx Slave Serial FPGA Manager",
> -				   &xilinx_spi_ops, conf);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(&spi->dev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(&spi->dev,
> +					    "Xilinx Slave Serial FPGA Manager",
> +					    &xilinx_spi_ops, conf);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  static const struct of_device_id xlnx_spi_of_match[] =3D {
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 9b75bd4f93d8..a3de365aadc6 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -609,20 +609,16 @@ static int zynq_fpga_probe(struct platform_device
> *pdev)
>=20
>  	clk_disable(priv->clk);
>=20
> -	mgr =3D devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
> -				   &zynq_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, mgr);
> -
> -	err =3D fpga_mgr_register(mgr);
> -	if (err) {
> +	mgr =3D fpga_mgr_register_simple(dev, "Xilinx Zynq FPGA Manager",
> +				       &zynq_fpga_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		dev_err(dev, "unable to register FPGA manager\n");
>  		clk_unprepare(priv->clk);
> -		return err;
> +		return PTR_ERR(mgr);
>  	}
>=20
> +	platform_set_drvdata(pdev, mgr);
> +
>  	return 0;
>  }
>=20
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index 125743c9797f..53a7b36f61e8 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -102,12 +102,9 @@ static int zynqmp_fpga_probe(struct platform_device
> *pdev)
>=20
>  	priv->dev =3D dev;
>=20
> -	mgr =3D devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> -				   &zynqmp_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	return devm_fpga_mgr_register(dev, mgr);
> +	mgr =3D devm_fpga_mgr_register_simple(dev, "Xilinx ZynqMP FPGA
> Manager",
> +					    &zynqmp_fpga_ops, priv);
> +	return PTR_ERR_OR_ZERO(mgr);
>  }
>=20
>  static const struct of_device_id zynqmp_fpga_of_match[] =3D {
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.=
h
> index 474c1f506307..9efe55be93bc 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -105,6 +105,36 @@ struct fpga_image_info {
>  #endif
>  };
>=20
> +/**
> + * struct fpga_compat_id - id for compatibility check
> + *
> + * @id_h: high 64bit of the compat_id
> + * @id_l: low 64bit of the compat_id
> + */
> +struct fpga_compat_id {
> +	u64 id_h;
> +	u64 id_l;
> +};
> +
> +/**
> + * struct fpga_manager_info - collection of parameters for an FPGA Manag=
er
> + * @name: fpga manager name
> + * @compat_id: FPGA manager id for compatibility check.
> + * @mops: pointer to structure of fpga manager ops
> + * @priv: fpga manager private data
> + *
> + * fpga_manager_info contains parameters for the register function. Thes=
e
> + * are separated into an info structure because they some are optional
> + * others could be added to in the future. The info structure facilitate=
s
> + * maintaining a stable API.
> + */
> +struct fpga_manager_info {
> +	const char *name;
> +	struct fpga_compat_id *compat_id;
> +	const struct fpga_manager_ops *mops;
> +	void *priv;
> +};
> +
>  /**
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
>   * @initial_header_size: Maximum number of bytes that should be passed i=
nto
> write_init
> @@ -143,17 +173,6 @@ struct fpga_manager_ops {
>  #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
>  #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
>=20
> -/**
> - * struct fpga_compat_id - id for compatibility check
> - *
> - * @id_h: high 64bit of the compat_id
> - * @id_l: low 64bit of the compat_id
> - */
> -struct fpga_compat_id {
> -	u64 id_h;
> -	u64 id_l;
> -};
> -
>  /**
>   * struct fpga_manager - fpga manager structure
>   * @name: name of low level fpga manager
> @@ -191,17 +210,18 @@ struct fpga_manager *fpga_mgr_get(struct device
> *dev);
>=20
>  void fpga_mgr_put(struct fpga_manager *mgr);
>=20
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *nam=
e,
> -				     const struct fpga_manager_ops *mops,
> -				     void *priv);
> -void fpga_mgr_free(struct fpga_manager *mgr);
> -int fpga_mgr_register(struct fpga_manager *mgr);
> -void fpga_mgr_unregister(struct fpga_manager *mgr);
> +struct fpga_manager *
> +fpga_mgr_register(struct device *parent, const struct fpga_manager_info
> *info);
>=20
> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)=
;
> +struct fpga_manager *
> +fpga_mgr_register_simple(struct device *parent, const char *name,
> +			 const struct fpga_manager_ops *mops, void *priv);
> +void fpga_mgr_unregister(struct fpga_manager *mgr);
>=20
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char
> *name,
> -					  const struct fpga_manager_ops
> *mops,
> -					  void *priv);
> +struct fpga_manager *
> +devm_fpga_mgr_register(struct device *parent, const struct
> fpga_manager_info *info);
> +struct fpga_manager *
> +devm_fpga_mgr_register_simple(struct device *parent, const char *name,
> +			      const struct fpga_manager_ops *mops, void *priv);
>=20
>  #endif /*_LINUX_FPGA_MGR_H */
> --
> 2.25.1

