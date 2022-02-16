Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F924B7ED0
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Feb 2022 04:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbiBPDij (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 22:38:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbiBPDii (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 22:38:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FEF9FBB;
        Tue, 15 Feb 2022 19:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644982707; x=1676518707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/dpiHs8GsvY1+g62Ls1RRluC7y5cBIKrNtnUMHMMDjw=;
  b=AFNtQdnIfKrLrGf2R/XiY8XKCv5Xs84WF+CMgc70HJi6kDrft5Tq950A
   wKwCzgVkzidR8NP0pjgOrbKcygaoRo7f5OaU1CU6H33DNF0QdTcai+BXv
   MRDl3h6aM9J1o4s+1oI0uJUlQEmQmlkSTU9oDvpWli3K8NAZRwGIXUfdH
   aSryUsmeH9+ucCZ+tZY3xRXWGLpXPCtq70RWkUwK2tEDD6gX6e25u4Raz
   g+T6b1ZYDjRwRUxNrYGWjH4Q11PSfy4dl//tY+8O2dms8zy2D5aKOSrCZ
   uvY/3wZ4pDGLNjUlP//QFHnUDm+dIS9wBzgpaHbnNJ288TYreGXD5/xv5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250253309"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250253309"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 19:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="544665151"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2022 19:38:26 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 19:38:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 15 Feb 2022 19:38:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 15 Feb 2022 19:38:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkTiLi0mqP2L+sNwsm/dHVd1XWtu6zDRqlM9CJQ0yNVXg5z+wGexXsmmlEGTj4H0lQNYbjcm4fdAKDEtsC5iefw5dzBMV2tQnrHAnu+MC2MFvbLhbQFAhHiat/AEdVNAUOq6qmcYMMIuUUua0LcCk2IoNPnClPpXk0rbgm7Yi4B5Zs8J0DSXP4akuco66OVUExngZjhvoINDBViyVS6mtx9O2nYSC9w4sEvRPr/yd3lW2dBtXTFbkYyVn1lY1iTAsB/1txisnSWZgj6g+CpgWzElXBDQQuXKrJ0StBb95o3l4ZAiBBWQckKS5phEPZxRElXzgswcbdWQncZ9zMBjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXKdBkJMXmEL4l5QupD+rQffVXXTTU8Qo1AyeeF+/3Q=;
 b=QGT5bwg2JOYTa6foyz7MiJkOQ4EGyAspjDH1T8HjUxc+6fWfV3YsBsDkaj+kL7y7dk2H15e8oLD+e9O3D6It7xP+AKvCC3+nJ7LTTu1eEn+P8HXswTELMGIq+ITXVY7tdLg63pq+uBkgqDofyTkY6Ek2wtrMh3L9S9WKLz4hIPAXmb8JrCLYbnFnbHblgEkudNoy3czLbpoCicugoolFvB8MXMJOuGuqYu6wjApB+pU3/PK0ZtNYfmsYFW6mmMS9uOnIuc+D7smpvw4AY5Ui1KFCBzWoGvKssVURxEmdML9rCIB9/o12Xuuhj9aEoIl3/QsZReZ9dgQUxq+nw3cPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1625.namprd11.prod.outlook.com (2603:10b6:4:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Wed, 16 Feb 2022 03:38:22 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 03:38:22 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Topic: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Index: AQHYIZYvrzRM3rjlj0CZJyiTNgRM8ayVe4hA
Date:   Wed, 16 Feb 2022 03:38:22 +0000
Message-ID: <DM6PR11MB38190E763522052E6C67730D85359@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-4-tianfei.zhang@intel.com>
In-Reply-To: <20220214112619.219761-4-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 732fcd6b-1372-449a-bbd5-08d9f0fdc7f0
x-ms-traffictypediagnostic: DM5PR11MB1625:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB16257CC597514DBBB2EE5DDE85359@DM5PR11MB1625.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqBZembuiLEz9f60bt/B3xJNSYZpHl8iuh6Y8pOnhxkdjFIXRSS7LM0Bzpxndd2NfdJC6sJmHYSmQ1WHEDQIFRkWZeDNldpdOSCIHrMBllTRzeNGwkk6xwKYUh8fgLuiTIVU0qWAqZH2dp3qe0lLOcARezsEO1N2gFPU6HsV0kUsCzWhHVBuI9JWAXx4KcZCLTJ/hjeIb2BUTToGCizqHyIpn3CuvT/bsfcEDvVBcDhcb9ifPmAfUWLp/PpVNxCjRepIkUneaP2cc1fvJPI9nGVuGG9XRL/jUnHx76RJP7zcCZIqmbz4R0qDVyIYvWCxJF6Ay71nOijhca9z7nPkXyftznOq9il4rnR2tsXMx97/b3N8x3FA8HeBKTvIBBMuMJdiA0i3LwvPT9pgOBi94lur5rL1o1rbrky5JFrB+PLxq74J1Cvec5DVj4XDH6ZN7xJ2nI0rS1neTCg2oFsjwv6RJqqkWXXNmuTPhx0O0Riwjl0xh64ag6hmcnI2wHkT2cB3K0ibHEza33+rGjbi0x/mlKwfs975fcNWEiLvyoDeRjibcSmaRJwGWgAcrMDK0QV2C24Q84ojhlBRM40+CCJCVjWhN1BSeEPpRZAUoUkmREgVcdikwInOc1jzhSlAVRmD+wXyiH04DTiBPi4gOaYCrbW8r7mr7aAH4asCG6IwWdN1m4eOScsfloDMPe9To6nUa/sg5ElCPkl0b9ue5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38070700005)(82960400001)(4326008)(8676002)(110136005)(64756008)(66446008)(76116006)(8936002)(54906003)(66476007)(66556008)(122000001)(38100700002)(5660300002)(316002)(66946007)(52536014)(71200400001)(7696005)(6506007)(9686003)(33656002)(26005)(508600001)(186003)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rj/1YFO0eHkc1H+bXbSyY61r9MKZlmdZ7X8Ms9Ehd9j7piOtZwvIBM3kgzpv?=
 =?us-ascii?Q?hxv89pSDHW5++RvR5s22HqtEhVAAUu/XlUBfszkUFj2rcqBlIM5ZxOQz5tSM?=
 =?us-ascii?Q?fGkutpOtWcCQzOZxr6X2UG8s7pzcY3X802lfDuJ+qonda+dXX6R5Scefrk+F?=
 =?us-ascii?Q?F6i7f4HXe0Hp7W+d011XHOTX3BTAG/VT6kmM2oI8PyeuH9jIdtmtDV88/84h?=
 =?us-ascii?Q?XFoRddKPDk6kmq3D/ITwVROmdlM4WDembI2tOrpo9h9iSLBxrm7eJwLxTuAW?=
 =?us-ascii?Q?wgBOfgypgjUC+607dINzArJRKv4t2qV2aqgYoOic/8KuOVFfjnGRWYQlohde?=
 =?us-ascii?Q?HZeFJA/P8m++XTV37yFI6w/t256im9AroTCHe8RQJDesSakIzWEN4jGHEnPM?=
 =?us-ascii?Q?WOr/1dRp4l9GGIyldjBm+ZRFVCkwjIiWA7ZfdllhYX0iqc7n2egB6LlmZrly?=
 =?us-ascii?Q?RWedjyirlNGyuzOG5j7sD7GZeEOns14BTcbfZ6bBHuuhNvAravStl5rmmQjh?=
 =?us-ascii?Q?PkPF4Y0Ayk3OcQaEdb6xGZdtNIB5bA/1opIwoY30VIDvyvooDLu7TtoN5wsL?=
 =?us-ascii?Q?e0k2MrtwZ4ytQoLt4axvYUqbhcSI7If+e5HQRXfyOD6HYHmv3yBZQglMCvPp?=
 =?us-ascii?Q?ENdDCliL1EsI5mUqEUFqMVVGSpO4SX+qB4r1MSL9KvCrIBVQ0vVF6c3h7mQy?=
 =?us-ascii?Q?Ma9sZxoHXDB3dCLlY1Q6PukjaoVxL1blBKWqRJ+cI9VWC4JRfH8j2dRxukvI?=
 =?us-ascii?Q?fvzK00PLiLah3zTHS8llDFQ5n5DjBkF4BllIpTVFf9vxpNrrP9mwNqn7wj86?=
 =?us-ascii?Q?JMg0y212dBT8wvZwssv0FrwseFxyTo0qFMVidbbC/g5MbAuJs7MP/DRSgzoY?=
 =?us-ascii?Q?wNWS5+1RBEhpklAQ3/NRbOWhcdj0AdR+/X1MPsA5S4BYv/INJxYNQYymfPiZ?=
 =?us-ascii?Q?WI68JctFt4UcSLRG+PDysXiux22GG/0amSnAcF14t17Cot/cT6GXnZv9x32n?=
 =?us-ascii?Q?oa8z0rMHPF8IWdB+7IwVMmxlgXRmKYpxPI7bsLGnBxH3UhJ/5EK8d7DE3moz?=
 =?us-ascii?Q?Gib5FQetxxHz9NUB24GXN9eebVXhn1HxN9dNv83r968dK/igZgrCr3I2cPM1?=
 =?us-ascii?Q?DITr10R3lo99YrGmguZcHN7qLClMgntnQU3Jil4ela0dYB1l2QH/Le/h3X3s?=
 =?us-ascii?Q?Gk2sXqLGx4ntp+z1ATIg7BgC1v0IGE6KdKo/MkluEXZeLm49ZFuQhmT17sH5?=
 =?us-ascii?Q?ippQVA8coZxp8g5L8Fjw112vM7RXXc92Pkz0FVWOxPpt/XOnC8AlFZoK86fI?=
 =?us-ascii?Q?rjms+0tmKgX7QdOCcRvGuKtlOtRuZFbmpxeDrYIZGeVpB4qizZtOFzX50KDL?=
 =?us-ascii?Q?pllpQJpGckWCJ3hvu6S4AyULk0agXIWMk3Gfc+9BTcvJbEW0UeG6VQSzHIHw?=
 =?us-ascii?Q?ijZkYjNq2t1gnkaR+Tdy5JHfC/gBB1YbaL8KptKpNz26XxR7ROSdVphxwQO5?=
 =?us-ascii?Q?lkKoTN/2zl7NokS69rB5NvYjLr6GhWDR7fFy+I/LhptaCqSqWj73rtqrBKU2?=
 =?us-ascii?Q?QYa9gLOzNz29/yGI1NieTF+eq2KB6+KkiIgfcYchNhkth/WJsAbD7AB/4yBk?=
 =?us-ascii?Q?XIHHYGJ+TplBhkxp1feMwAQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732fcd6b-1372-449a-bbd5-08d9f0fdc7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:38:22.0220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNhsjFQKjPNI2L1O60Vu17cEhre4vVMqRyYaS/NHfgYL3nSti4uLZ0ihRUGBvtRrz2Oz8/sS4bzyOa7OV7km3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1625
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar spac=
e.
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> From a fpga partial reconfiguration standpoint, a port
> may not be connected any local BAR space.  The port could
> be connected to a different PCIe Physical Function (PF) or
> Virtual Function (VF), in which case another driver instance
> would manage the endpoint.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4d68719e608f..8abd9b408403 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -243,6 +243,7 @@ static int find_dfls_by_default(struct pci_dev *pcide=
v,
>  		v =3D readq(base + FME_HDR_CAP);
>  		port_num =3D FIELD_GET(FME_CAP_NUM_PORTS, v);
>=20
> +		dev_info(&pcidev->dev, "port_num =3D %d\n", port_num);

Do we really need this info here? in FME there is one sysfs interface for p=
ort num.

>  		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
>=20
>  		for (i =3D 0; i < port_num; i++) {
> @@ -258,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pcid=
ev,
>  			 */
>  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar >=3D PCI_STD_NUM_BARS) {
> +				dev_info(&pcidev->dev, "skipping port without
> local BAR space %d\n",
> +					 bar);
> +				continue;

Is this change for IOFS? From patch #1, we have FME and PORT on PF0, so
we should have a BAR for PORT on PF0, is my understanding correct?

Thanks
Hao

> +			} else {
> +				dev_info(&pcidev->dev, "BAR %d offset %u\n",
> bar, offset);
> +			}
>  			start =3D pci_resource_start(pcidev, bar) + offset;
>  			len =3D pci_resource_len(pcidev, bar) - offset;
>=20
> --
> 2.17.1

