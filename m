Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA374737A09
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Jun 2023 06:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFUEBZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Jun 2023 00:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjFUEBI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Jun 2023 00:01:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C01726;
        Tue, 20 Jun 2023 21:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3H3clNI7VYOwPf4tfdSGmx0mmGuYT9ug9nKHMb8vwCBTVzwwSlnPXfMDJAMpH8EVVCvrY9AahaQlI+Nduu2jPKa2okTxSa06euvZ7FiVsAJqfSxo5r4C8zssDiFM5f2cCtd4bHCoS7D2ZiNCFy203pt98EeMduJJ3zOHnFsRLgwJxHKNA2FEoXjyLR2M4lbihBasifKDNUX0eI9Itgx5wJn1WzY7kXvbLGARM8dY8dPIIkIwyShnR0L4kj7EgVz5Ew8NfnafpjwqGUm7VmfJ3bsBAbUF5KNRweGPEgmCZ79vUV1pDn73cze2ALJL9Xh9LyMwdsPtDveVCwK7/FRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IS9oNhHykzQk5EZtFXhSwicO+DsM0RiX+6rwgsnphg=;
 b=QoiPzoSdsxO52k1T+L9atO97vTpzc8ty7ifpzenX216f74nY5FsyRcwWk7Po4emfkkUblTWGAr6+GAu+8NMIz/ZdXWZG1cXDBn8RiBEIugDKmF3W4BIUSXYnspoOQ4DWdWMSDF2T8S+v6JncoKsb78WluD7ESbhXMiyvYmO1Slpqp49NK+UZxU4jvuUyf08H6ENb8LmcB5XMu7updGk1NbrrcBY3z4SUehSSr3TZJOwl0/UvqaXLBPfKEEyv/FTgN9yFuvgn1q1ER6DDUSILJy2NxhPr7tXbN3Eod/bJVK8Cxfmanygo7Ejy50zRE6n+nrtymi1ehKjl6uuucnCzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IS9oNhHykzQk5EZtFXhSwicO+DsM0RiX+6rwgsnphg=;
 b=oFp2rkjpdmbdP59cAO/YSBNH4T+HF8wm/pC19BVAy0A1Y4PGtmWTNXjulDEp1AVXfEZfB1QE+x+S31r0VGlhd2Rk2Jq3qa263tb3AuN8cgSJIsKRLqDI7ID7vasT2WYMXHS8nRlPBfdwg8kNYH3EtvgESOMVJOesREKP0SVUoI0=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 04:00:53 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::a373:63a6:ad90:bd67]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::a373:63a6:ad90:bd67%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 04:00:53 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [RFC PATCH] fpga: fpga-bridge: Add manual set option via sysfs
Thread-Topic: [RFC PATCH] fpga: fpga-bridge: Add manual set option via sysfs
Thread-Index: AQHZju7uJlYW+7WqzUmG3ee11N9kt6+Uy55g
Date:   Wed, 21 Jun 2023 04:00:53 +0000
Message-ID: <DM6PR12MB3993C315D875CE44CA1A0B29CD5DA@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20230525095438.2766625-1-nava.kishore.manne@amd.com>
In-Reply-To: <20230525095438.2766625-1-nava.kishore.manne@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|CY8PR12MB8297:EE_
x-ms-office365-filtering-correlation-id: 9fd296eb-71fd-4d4e-24be-08db720c1bf9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vQjjPv7yW2dnj934CRR1Q1EzOJK9p7zTHdz1pz0Na71iYhNV87lFzHaUuQ7hBIkPvlUzNS9m5S1jZIQ8OZq4gxwqYI3XRbjdqxpB7qVFj56yl812bbYL+7f73FMq1q2pqxSaHfhcYAXrzDvK02bKB2fvYpMaWGoQZzeuXV2ND2jVgaQVpADS/4h90qphJ82QkBXq/ZCGeb5vyqkZ0yRlhSk654RcpSy4DtT8+UmN5AQkPdOJeI1phievXT0i1CYjdzHjeXQoMwHFSK8k87hcejoqZipuG9xDWLs6oPbDxCuzHy2+/30SkR9KR38JiUqWnW9dIYAdgz2oho3J73QvShyao0Lklw+PkTDPvwfYXm/oa5sWpJaItIBrQE8gwo9wqOfwnEGI1C08zx7iYyGlYmkb1agSLlohjdzGlUFIHgAl3R1cTa6vWPjnqq89ZTZTT4MYBuN/Q/6Bxftze0PI7ZxLq9m0sny29smZN6mYaLpGuJarBBT2DicGOILXYf2FavxtMTphVZuDeuMXAX+lPT7KTLmeHQfvNb7R9MYIGvRg518cx/Qxj/ibTqdLvMavjCUedxdEXJDNMVGVChvSiOiLHCQH6a6O/yO99ne5hNXreEIQc8K/S9WaIxsKrO6ws3zXRr1s0UFflRIUuJxssQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(186003)(8936002)(8676002)(66556008)(66446008)(66476007)(64756008)(5660300002)(76116006)(110136005)(26005)(316002)(7696005)(66946007)(33656002)(71200400001)(41300700001)(478600001)(53546011)(38100700002)(9686003)(6506007)(55016003)(122000001)(38070700005)(86362001)(83380400001)(2906002)(52536014)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T2KZxKaldg7Wg1oLEcLLKnr+iwr/stUYxzl4IhKlRkKQjs4vHCcw98K+x82I?=
 =?us-ascii?Q?d8sx61XiB/Rkp12JciGvZW4j0DmdWYs1hizn21sq16WqvFkQ4ThXH1hTurmD?=
 =?us-ascii?Q?MtDaxQyk4txOQpqqdag3+NSPM00XuyYe/hJP3sPYwOwz6EyL7l7HPqtzp72+?=
 =?us-ascii?Q?jdeoorzQ9JuXKRVMwkGU1NlHqYJhWqxJtcjooVVGJbiu2jGdtZH4v+gXKtEW?=
 =?us-ascii?Q?00INW1XN1pnjobDucLsJ3vGtf+E/mKRt31GWT9VGpl9H2b9u9emXBn8bLS3X?=
 =?us-ascii?Q?0/7eDX2hnItNRXyBZlF7I3c42KqIXiCZ+dz2GAifPeQZ7r9mJMEf4r1fqAjk?=
 =?us-ascii?Q?f/55l26maRGtydEPNEMwGHaN6yGwpp/8Mp8gzLeUJldZRsdN0VXmQVNikh+Q?=
 =?us-ascii?Q?W7IaVyTNSkI9Q+K56nThC4qNflYfgNlB5/ztUVmA5YGq3YJQFg9CYVIahefA?=
 =?us-ascii?Q?JqhXRJQvyMlfKL/cn2a/brsb+NqRvKAzm9mQPBRCy7t7xhqhRD6roVGp4V1R?=
 =?us-ascii?Q?rMoJgZSH1w85RGvOQZOMaNFH+xpWUvw/uhodRubpOPeyM5YjEMAycg8Xp7mN?=
 =?us-ascii?Q?1DIhvdnXemd5Rf6gMhGktu4Y8KhYCGSzYD6WsT//1b/EJTExjqjoww+UCQAt?=
 =?us-ascii?Q?vC+dtu6dkPtVsjsDgUQ1xHFMeWrPjNpOuAbmxhnIcO2kjSQUT/mU1LFfdE8B?=
 =?us-ascii?Q?TIyUTw1Fof968tm0fv0XbD2Reu6snFMy7wCf9cfIT3KOM2wD5FhbG28pXZsE?=
 =?us-ascii?Q?lrRD9c/YWSJECSUPHDpxfA8UkTLu85Sqv0yrWmS+7T2GoAfNKf/FCTpjZqjc?=
 =?us-ascii?Q?Ft1PahTC2Nd+rz5OVCmhqQeq070IAlFBw/Cp9qXJP39Ab8uFfWrns7dVo4q2?=
 =?us-ascii?Q?MKGCYcCJT86Ds66LJ2mjYTVOsnFoQiLrODjLc4EPlPBXAWZqCjYY6qPRDz2z?=
 =?us-ascii?Q?n0XVwO3hEg/aXgLoFCkSf99XKJuZ8i18y+4l3/+tlu3OzECWzBqZcSNGkg9U?=
 =?us-ascii?Q?07Vr18pTyTtS+hLFfBp8k8iPYPcFCu6YcecTn3eqMbHkpz1ovMgf5f1SLzbH?=
 =?us-ascii?Q?bEB5UzltaZMrEJGc6Fjd8nNWizva5LK4fARSwx65e19fZk5zOJuuYim1LlvW?=
 =?us-ascii?Q?dIhQxKczkefkq8qKYyPAr3BP0AJILRJpFnr5NekMV0PrHy5DU3sgSYIcoy+a?=
 =?us-ascii?Q?k44IB59kMF1nObu/MQ/G82C/UJwE5N5rzfNonl5AKntL5dp3eMdd9qR5wiMZ?=
 =?us-ascii?Q?JsgCMrd1f/9NOeth442+ZkmbnAE6zLNyN1A54jPZ8Q2JpNRjEUR5ZXsYfyPW?=
 =?us-ascii?Q?5xXpeEZ719uwi74NQO/00FaN+3vEa+BbMa72B3dwzPnFnWTEQ47BrZ8M6kOA?=
 =?us-ascii?Q?LDkxyLlI2BQwSv5sgsSGzoA9yJu784AoPPN5JfVkpAWj9DmEl+6Dujq/Um+l?=
 =?us-ascii?Q?w09KMXLqbc5Ii4FB0UQaKt1HsNCqecZ5tN2vqbF+7zCgyPSNea8XGc7gCdja?=
 =?us-ascii?Q?2T4PL9Xk1oPi2/obUbT9DPBEvzxaqOJb/CWGRT2j2XHcQrdN0XR4vf2dQMNB?=
 =?us-ascii?Q?VQT94m6cf4KcXAFXGOA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd296eb-71fd-4d4e-24be-08db720c1bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 04:00:53.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaFTA0xpA3BMSO3oxCX0ao/YwZIuv+o8WmhHeYhJWib3JGnFsr6VstpqVN83sQgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Sent: Thursday, May 25, 2023 3:25 PM
> To: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> trix@redhat.com; Manne, Nava kishore <nava.kishore.manne@amd.com>;
> linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org
> Subject: [RFC PATCH] fpga: fpga-bridge: Add manual set option via sysfs
>=20
> This patch is intended for manual testing only.
> It is provide an option to manually test bridges.
>=20
> Enabling bridge (!0 values are handled)
> br1# echo 1 > /sys/class/fpga_bridge/<bridge>/set
>=20
> Disable bridge
> br1# echo 0 > /sys/class/fpga_bridge/<bridge>/set
>=20
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  .../ABI/testing/sysfs-class-fpga-bridge       |  9 ++++++
>  drivers/fpga/fpga-bridge.c                    | 30 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-bridge
> b/Documentation/ABI/testing/sysfs-class-fpga-bridge
> index 312ae2c579d8..e157eb737bfb 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-bridge
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-bridge
> @@ -9,3 +9,12 @@ Date:		January 2016
>  KernelVersion:	4.5
>  Contact:	Alan Tull <atull@opensource.altera.com>
>  Description:	Show bridge state as "enabled" or "disabled"
> +
> +What:		/sys/class/fpga_bridge/<bridge>/set
> +Date:		May 2023
> +KernelVersion:	6.4
> +Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
> +Description:	Manual set bridge state (0-disable, !0 enable).
> +		Enabling this option requires that the module is
> +		compiled with #define DEBUG which is enabled by default
> +		when CONFIG_DEBUG_KERNEL is setup.
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c inde=
x
> a6c25dee9cc1..54d15b709b10 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -13,6 +13,12 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>=20
> +/* For enabling manual bridge set(enable/disable) function */ #ifdef
> +CONFIG_DEBUG_KERNEL #undef DEBUG #define DEBUG #endif
> +
>  static DEFINE_IDA(fpga_bridge_ida);
>  static struct class *fpga_bridge_class;
>=20
> @@ -307,9 +313,33 @@ static ssize_t state_show(struct device *dev,  stati=
c
> DEVICE_ATTR_RO(name);  static DEVICE_ATTR_RO(state);
>=20
> +#ifdef DEBUG
> +static ssize_t set_store(struct device *dev,
> +			 struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	struct fpga_bridge *bridge =3D to_fpga_bridge(dev);
> +	long enable;
> +	int ret;
> +
> +	ret =3D kstrtol(buf, 16, &enable);
> +	if (ret)
> +		return ret;
> +
> +	if (bridge->br_ops && bridge->br_ops->enable_set)
> +		enable =3D bridge->br_ops->enable_set(bridge, !!enable);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(set);
> +#endif
> +
>  static struct attribute *fpga_bridge_attrs[] =3D {
>  	&dev_attr_name.attr,
>  	&dev_attr_state.attr,
> +#ifdef DEBUG
> +	&dev_attr_set.attr,
> +#endif
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(fpga_bridge);
> --
> 2.25.1

