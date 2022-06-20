Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AAB550FBC
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jun 2022 07:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiFTFiX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 01:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiFTFiU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 01:38:20 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C695B1;
        Sun, 19 Jun 2022 22:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcw6x5WrAGu9WjlcvLWVlRSZqb/RYur/uwuKbFCeV/kea0jFkylB/dMg1FdKXS5sANFAbeZMsMWBfojVP40of6E02vzLJ1nLQaPUDZwoVGjfp/ZU2ta5YJ6W2TD7MqYOwu7VJmbQLbNyhiQINaWms4AGZu+mlKpOEXuuFxfn/OFCu/oJaimLWpneK5+6OfudIGt2vUd66V6zqFiu0jf6SqLeD5RzwZxSTZ04RfnNT7pcfhQgX8Q/NM6Gu83EqR9XMRHG0jb51rnOKmQmPbQHEbfiZuQAhmvM6MZN7ojXOOojc8f5BR3nT0WKPwcdsyLEsl9Ao6+OQrj1hSDGyZPrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLYcousuluVJJAeZgBm0Pq60/g9PBnjFWZW/7M3Wa8M=;
 b=jpH6gKnSCuv+1HOqbYX20wF+pmCRQwnjlC1XtgVm5Qp7t4wCPhDD+XN21kzwEbNf1+G92PDsjdxRI4S4/PWyV/+zcJQt67l92+bVSg6krjPUrxt+nVqNKHa9RAW2RIEb6yG95eyaLoeJBp7++XT+DsX6T1iD5QvPWfBgOBZCT2UxioYel58oXuAfQ530yIPZlgS/ElOdnGyxtLrBk4C27udI6UAR2kIKlzu/CVWXZkZDhUZIBlcyxC1TDEGOpCyH7e3bDXS5CkIMVaZ0/QpUOyK6ScmZksrqYrwBS7YCUhQyrzpCrBenL79vCkFqTQQLs0SJkLAjWycXSHmzSViu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLYcousuluVJJAeZgBm0Pq60/g9PBnjFWZW/7M3Wa8M=;
 b=e9DUUEx7nT0TtdjThlkGCUvErVtpVpVRxABLk0hh2OG6TSe5Bk7ft9DX4uTrmZY1EhCjs6WiSlOw+R+053sdD8VR5rvUYwXiZy7g94XI/+wBHvaW1ftEM4TRwpCcoCH/MxizqTd1by80WOB6UeL399aKndGnc9az+Rk0c6dIehw=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 05:38:14 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::c850:f1e2:40ff:2324]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::c850:f1e2:40ff:2324%7]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 05:38:14 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v2 3/3] fpga: region: Add runtime PM support
Thread-Topic: [PATCH v2 3/3] fpga: region: Add runtime PM support
Thread-Index: AQHYbqt2k6WhHHAuxk6U19Lom4CxBq1X8mzg
Date:   Mon, 20 Jun 2022 05:38:13 +0000
Message-ID: <DM6PR12MB3993A1FF3517D99AC9A1C21CCDB09@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-4-nava.manne@xilinx.com>
In-Reply-To: <20220523134517.4056873-4-nava.manne@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1820864f-5789-4793-bc26-08da527f11d9
x-ms-traffictypediagnostic: BY5PR12MB4273:EE_
x-microsoft-antispam-prvs: <BY5PR12MB42736FB04F6400F3107E5782CDB09@BY5PR12MB4273.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3usx7PHa/krj1KuDWoa24wRV6gHhEh+ugqVaG3yRJjjg6GwprfhvZ191clfxBjXxjwmXAFYtk0qJrSGzVsyXiHiBjs9ax4PyxkFaiJpxcuk5nHUbymqebCEhF9JNLkCXys9U9TnKS66lWow2i+De8VAmRDKXOC5tIZ4QqMBi2PxKISE7uQ2+g+dn9rn6tiG9APKRSO3VZyhR2J+ZFnTMan3wfV47Cn9cB2uBRiOsVFT5VSb8ZYBegN8Ib6SeyYddqIeUVV5/EV2bYPrstep2Dd7K15ycRQvVLfa2QnWw2zCse+IisIUrK0vPO5CFkTB361j2B/bnCXEgmqe+sSJTlx2rTp0OEckKUauwSgfwxCYdUaU2jJD1SmboyWYbaI8FYRVK4l2vyc16vlrazpUfcWe5ZSX/2CtXHgZxr2QXrYwsyEFGTp1IiuuG/pjFUTksR3DE+eYAefQS5rx/rK2ZnDzaDkAOSAUqxGK9EtWf8OZhaXG0NvaQUnqTK/KOBz83wkqIkgl02K3D40OF8F15+yCNx4BkZ9pzi3YId2Tuyjz/6TDQBA0eMtapyiJr+MhaFJ/Q5SOf3xvZntLLsTwnDxLa33g0p5lwbFTNFBfSC3psIIipZN5MI1aVYhUmkIk2BwMG8zMgpiFxetFywK2yRGwEMd2ZTFJ+te60gotCeY9EqLmuxUpOFvW/yA7Y/DLKxyMIz7LKZ+qZrmbVuOffixypHsn020mDcBRx/P7JxgY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(478600001)(8676002)(186003)(55016003)(5660300002)(66446008)(52536014)(33656002)(26005)(76116006)(66946007)(66556008)(7416002)(64756008)(66476007)(7696005)(2906002)(71200400001)(316002)(8936002)(38100700002)(83380400001)(110136005)(9686003)(41300700001)(6506007)(86362001)(921005)(53546011)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R1i56FIbEIzLnzGRyWERSotWsQzLz8CZoDGxV288QicjuyW4aAdomzQUZLyh?=
 =?us-ascii?Q?cKh7Sra8TXwKsCPHpPaK00YnBH6yBQez+rIoMpSge6dlyui5om2Lp7g6EIxx?=
 =?us-ascii?Q?quSo9V93G6eWSq12h7QSElj1jEi2rFpM5opzrPAoGJuXCh92uAYeWocKRXVx?=
 =?us-ascii?Q?E7w40tsIjyCaWgh6bnW0n8STdGDwR7vlFnWmUYoYEyLVo3t5x+P3b3+P2gY/?=
 =?us-ascii?Q?Okl897FTD0NVXXim8HVxesJ0czHB/w3JaEPbIF7v6g0zPwh6vKUpsRF9+f6j?=
 =?us-ascii?Q?qSLZX58lvluhJ54gjSZPDz5PB4JufouYzorkQM/9Hh+g+so0577TBIXA6BsF?=
 =?us-ascii?Q?TmYtjMTVcrfSfavU3LyE4AtZ0l8sTLDcRqhIdB2BprK2mrTtXHxTuA/mWgg+?=
 =?us-ascii?Q?ejVt90nx+D/pU53sDgLOJ1XC9fg1Szo89q96vECDbNG/me/ZzI+kMk5DKfIF?=
 =?us-ascii?Q?dwigcYwKuu1XrgC+K/rLA4T2IaWVIrYqYRBrl1+2mqaQGrWJmGpOnzZuGTZL?=
 =?us-ascii?Q?skV+z6XJqznTimBL7OD5Fax+xlKK5ahkPL1iFMDemWPLelaen6/ZRiKwZcT2?=
 =?us-ascii?Q?V6MHhYPB7uIk2xs9Dzvoyxtrei6tqc0y6QDXXxVfZmFNMXr7uZLvieqH84IA?=
 =?us-ascii?Q?ML18iaqK18m8t7xcPIyXwTyKpCtSRp4RUPLh8yVLnOULb2lPcquNOgeJxtJr?=
 =?us-ascii?Q?Dijj03uxeN1idXOz5QKMJMTFLKK5Tj3aupkPlau6td9SZrp1dJpQCw8IKrv7?=
 =?us-ascii?Q?whN70seOa04Glh+SQUefRvzfzfLuNhJ+DEF8WfENhalr+W8GuO/edM5THoyC?=
 =?us-ascii?Q?vDyILyjWVn7AGf/K/vP+QtkjTqvx1rCnWiUfXxcZLu1NBb9sUsZoXV+4fwOX?=
 =?us-ascii?Q?muT5xW6l5caioDmWe9pXkr5c0pPueVnrghWX73NLNyQkxA49MOwLoORQR2gT?=
 =?us-ascii?Q?HhWRjgS6HsuJx+BMfZAh8hIBdu0DSaWSh+ikTiZwiLn2v5Sor6/CaehOVLhW?=
 =?us-ascii?Q?LkEfkBCNE6wooMXhOaIS2ffjPZ8XHopphKmrMU8MJ409q7LVVheRmaUaS3if?=
 =?us-ascii?Q?ttP7eVki6ZAdz4pg+3nReOl79t9DA67KkUUpYQpljgI+TV8jfPHJ5E+u/05m?=
 =?us-ascii?Q?m/cckUL5fyORpHvIer6pg0B9ruXQ227G7Jdt3n85LJOGHU0FCNub4Bax8br7?=
 =?us-ascii?Q?w+bLHppSvr41E+0Hlfi+CCIF619zhjQSionRCer+rSDiblTK0EaG64ovzxCd?=
 =?us-ascii?Q?/AC3OXnBBEhXXxim4dgr/nAdbv4P9oYf+Y1tchvFODWO+QVA2ZHeWXQ1ZWIH?=
 =?us-ascii?Q?Z1ZRZNrkFa1d5f3xuIzVlcRo7jseJx0kEKqzfnOeTjX15J4Tluh5CH/sujCZ?=
 =?us-ascii?Q?5kfNGA/oIUFuzbpJYfNfS65IyFgoajxwKHMekdyZZLQK3Xm0uu5CsTJx09CQ?=
 =?us-ascii?Q?Uk8wa2Q2Q6tbWFwUejq+s8fBHBv9DTWzow0F7PdeTFQkusEk1Yu78r2VX9lb?=
 =?us-ascii?Q?0y+H6Vdzo6fOjVpug/5wlq+GpSx+sl47GIBXYDz1WU8+HL/Sa4X6f7bEvsRL?=
 =?us-ascii?Q?BwpUa7cawdgGjbcAz4Sa2yy0GU6Rn/219Ble53OODPYy2IM6Gq9v1TB+dwIA?=
 =?us-ascii?Q?V0bouF8Z1rosgmgKHHEBTtX6YBElVvC5/+4wQ5CXrrumjkd4nOXyX/Z5QFky?=
 =?us-ascii?Q?uKRLmrYvJ17TJ+JImPzWjQzwGmR7M2vqMV1xkr4cN7cQQAS9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1820864f-5789-4793-bc26-08da527f11d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 05:38:13.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IItal/7+GqwLVNLk/hxcY44n8yJp4gX+MtPmeIvyNU7iYtuLDKznSPSsa9wef3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne <nava.manne@xilinx.com>
> Sent: Monday, May 23, 2022 7:15 PM
> To: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> trix@redhat.com; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> Michal Simek <michals@xilinx.com>; Nava kishore Manne
> <navam@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git <git@xilinx.com>
> Subject: [PATCH v2 3/3] fpga: region: Add runtime PM support
>=20
> Add support to handle FPGA/PL power domain. With this patch, the PL
> power domain will be turned on before loading the bitstream into the
> targeted region and turned off while removing/unloading the bitstream fro=
m
> the targeted region using overlays. This can be achieved by adding the
> runtime PM support to the fpga regions.
>=20
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>               - Updated commit message.
>               - Updated runtime PM handling logic to fix the PM ref count
>                 imbalance issues.
>=20
>  drivers/fpga/of-fpga-region.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.=
c
> index ae82532fc127..f14bb5916d97 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/pm_runtime.h>
>=20
>  static const struct of_device_id fpga_region_of_match[] =3D {
>  	{ .compatible =3D "fpga-region", },
> @@ -301,10 +302,17 @@ static int of_fpga_region_notify_pre_apply(struct
> fpga_region *region,
>  		return -EINVAL;
>  	}
>=20
> +	ret =3D pm_runtime_resume_and_get(dev->parent);
> +	if (ret < 0) {
> +		fpga_image_info_free(info);
> +		return ret;
> +	}
> +
>  	region->info =3D info;
>  	ret =3D fpga_region_program_fpga(region);
>  	if (ret) {
>  		/* error; reject overlay */
> +		pm_runtime_put_sync(dev->parent);
>  		fpga_image_info_free(info);
>  		region->info =3D NULL;
>  	}
> @@ -324,10 +332,13 @@ static int of_fpga_region_notify_pre_apply(struct
> fpga_region *region,  static void of_fpga_region_notify_post_remove(struc=
t
> fpga_region *region,
>  					      struct of_overlay_notify_data
> *nd)  {
> +	struct device *dev =3D &region->dev;
> +
>  	fpga_bridges_disable(&region->bridge_list);
>  	fpga_bridges_put(&region->bridge_list);
>  	fpga_image_info_free(region->info);
>  	region->info =3D NULL;
> +	pm_runtime_put_sync(dev->parent);
>  }
>=20
>  /**
> @@ -411,6 +422,8 @@ static int of_fpga_region_probe(struct
> platform_device *pdev)
>  		goto eprobe_mgr_put;
>  	}
>=20
> +	pm_runtime_enable(&pdev->dev);
> +
>  	of_platform_populate(np, fpga_region_of_match, NULL, &region-
> >dev);
>  	platform_set_drvdata(pdev, region);
>=20
> @@ -430,6 +443,7 @@ static int of_fpga_region_remove(struct
> platform_device *pdev)
>=20
>  	fpga_region_unregister(region);
>  	fpga_mgr_put(mgr);
> +	pm_runtime_disable(region->dev.parent);
>=20
>  	return 0;
>  }
> --
> 2.25.1

