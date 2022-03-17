Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147E74DBCDD
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 03:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbiCQCGK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 22:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiCQCGJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 22:06:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD761DA72;
        Wed, 16 Mar 2022 19:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647482694; x=1679018694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XlWlKK5HeIY2jt8BACdmC751Q7fSnZUXfTfGrAtFa/Q=;
  b=LyMdpAsk1nwko2ZCWGc0suEVcQyMvtP11VGIQuFfpcWk/hW6qyOFIvOa
   R+C/FdNSUOesrD5M/+xb47S0A1qzd34z7JJ2jGfL408M5fuu2E+e9CDZv
   CojOZjGO3M1fpvBXfJm46brUdHRgXJwfErxas7rdEk+QZtLgsdFfkHbSh
   TEDGIicXB3XyEci7KcAKg6QfOwfU/2Krs6TvIr8tF6m5OMEiEdUOClS96
   xPqmc6xjAEkg9oV/556diGg2AG4SY1KM3SK+e9Xil5Dk1HSK4ViPrwoNB
   uRm4jbhXr02vbVogx1wGbGs/wf8L/aZLXe12Xp4y7SCI5oM2g/9MbT/Av
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244214582"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="244214582"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 19:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516583351"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 19:04:53 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 19:04:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 19:04:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 19:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkK0pIaoDJ3qWGNDCQh/iw5PH6SIQf+2g537Nqhe2cN9xQGVv30SOWUMOUs9+Oer+pPra1rRjH8KEiwUjABxHlnG4pfzy9HDD48wSn83IKbOUv1kbqLHOpTi2jAPyU8R9u1V1hswQhjBVncstySfbu04kFmC5Ip6aKzL5OTZYyMb2Sjswt7IV0oSrztvDJkrGaiJmyHRrCKYMItXUEmEH2UQT6Ofb4mP/5XY0OMHMevNFJsPJwCJ2XItCHhwmafHlqGESDwW5bh3ZXMSYo+v7n2ErUuW5bwclJQ/vCG4SOo11aiL76RGyJ794mhwA985pxS+kucy0i+5QYeyFP6pOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss3UyZMv138ljtr5bh6B6R4WqEfLWO1hw7T6PHHJn+c=;
 b=CnmXDj4LbffD1LPqRkmC/astTW8UqypvC52LEOtFi6XWtJMI5RphVoEU0fRs98CMbC/re6goJSeLtmU0aPpQkZjybO8uUtRVBYHLEPeq0sjuTe17TEqo6o/FSt7DpbNchtVbVGc3TL3UO2ZoBhlgqj/l5VlLHUdyfVoPk9Sc18KyO9DfJOCEdmBDJIXaKVECN9NwtRv2xXc04N5rgVaAQVE5mAGyDoWHX+KHhFt1JE79cLYrPy18G8PvXLyNG/riaIoPQ+hS1asTTid8jzMLkfn1xgaNgFyQVJZAwPWcUoN1jJkyWXz8Ok4UfJY98slg23c6uHBFPxfnK5YLlaB7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3816.namprd11.prod.outlook.com (2603:10b6:a03:f8::32)
 by MWHPR11MB1968.namprd11.prod.outlook.com (2603:10b6:300:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Thu, 17 Mar
 2022 02:04:41 +0000
Received: from BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::b03a:2ea1:4a3d:1e55]) by BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::b03a:2ea1:4a3d:1e55%4]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 02:04:41 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Topic: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Index: AQHYOQUc6KfnoIn0pECU3HlxJyPskazC0EmA
Date:   Thu, 17 Mar 2022 02:04:41 +0000
Message-ID: <BYAPR11MB3816EAB6CC0047B2DBB5086685129@BYAPR11MB3816.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-2-tianfei.zhang@intel.com>
In-Reply-To: <20220316070814.1916017-2-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 6615deb9-04b6-4d8a-7349-08da07ba7ff6
x-ms-traffictypediagnostic: MWHPR11MB1968:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB19680D1490CBF9FA7C93C90D85129@MWHPR11MB1968.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjf4e9Gt+75e68fWb4IZ1syJgKyG/lz1Fk9GuZhsRa3G+Owuj/LNRL3kAmDQlmi8YYTpq7U7KISFRr9UGlmngs60TVn1fz+UxL5Q3dRHYzP+QsoRs5avLFR9ipwHztIh+mD0kDOs96w9nc7fb5oSg3GlzGt1qulhPlCRwZJRtQ6HJEcW1BFMSywyxF7owy3VpUpNjzOO7oDn9mcEq1VmEnyqhFT56qP1Qd3F42KPZFfIv91BtAN89RRzMSuzXjav3Ev2HEl4xEPYnM8/6FCvp7mlLKE5asdn2kSB+fZK366T4DWBXeynRv3qghkSB5utP4xzE0tT0KQ47QP2smFLIGAJ6djLZTYwwyBf5RgLWGTaQb0S5IBQEN98Nr1a8g4NVelw5TCe9M0XioFZCs48olDMbL8jRBYbHDr5H9ypRRanyNERpztH5lU1mJwLh0VvdR//WxVFAqyv8V8m2nOddTe/P4j8iXS0PzcevNVQuEnC2K6DtTdx97WMs2xcjwPd90oZMshe+6Zkg7qubyvqxD3BV48Yvf+xjVH3pSu/OfxIkqxZfzgQc43NgAyWKn6PmRJiAMkckaeu47VLOlv7+IrNpA8HPE97n6FLOl/I3VWqZ/JxJZc0xh3U9LtFpSBKrp/JxSQF+tV4AUqaZxJet0sIo+rQ3QZllHEEJ2pRMBobFLVZYe9M9uuUMEwbmg1AYRafqFnztQYweAjep5cHYY4pOzt6FZRZEJyoyY7zlBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(54906003)(52536014)(5660300002)(6506007)(7696005)(316002)(83380400001)(508600001)(33656002)(8676002)(186003)(122000001)(82960400001)(71200400001)(26005)(4326008)(9686003)(8936002)(86362001)(38100700002)(53546011)(110136005)(2906002)(921005)(66476007)(66556008)(66446008)(64756008)(66946007)(76116006)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f0kwmmUyMyPth1nbVev77bMzVzzEzBNRZs9/zSwj0lyqW5SU9JusRBRONU7O?=
 =?us-ascii?Q?bhIT/vzbirOi02Jip89OgD1ZVUjqIkOTZDfegovKeZV13xmklAHDVpU8opLd?=
 =?us-ascii?Q?1DTxW2K8QK7dEMrkRJDGha75Cp/gJTaGfjK2vJf9wFwJTc29TtpcZ3kmut9A?=
 =?us-ascii?Q?dBMXVlNpjES81Ij/i/lEs4nWxChQ2IdF8rHI0j74D8AM0SdiUUhO0/kCHb2g?=
 =?us-ascii?Q?qsVD7TZ/5HeX7erNBgJWPX9mkK5tbrLAHpEgCkiZ0Oh2Sz8rmvY9nTH/aX2m?=
 =?us-ascii?Q?e1UDtIc+mVC4BjNmgyN2YzO/9A/E3PhWZPABxb+RfD+c++gQ3SGdMjzZRkL3?=
 =?us-ascii?Q?mrZ+PU8lpXgnzlwTNAM7TbZ/BmUKwDovNJ2MMDtD/+e/GuE1Ai6JnbuUmHF7?=
 =?us-ascii?Q?K36yT+xkoYu9+83xSC72dI4yMPR4hcu4AU5LrLrDk1Ac02fhLgV+7ELuU2z6?=
 =?us-ascii?Q?rrR0+FFuLQtm2X7IDxuLzTzd8s4dQ+pOYif0Bk5vb6GnbZ59SbWnGeqcFlsv?=
 =?us-ascii?Q?RUpg0Ro9eEvdBkdqPXow4prlgs3DV7jPb6bb56dJ3ggr4Qug71mnIXpHZIIM?=
 =?us-ascii?Q?hf54wMYimEeC6mhKaB1Li5MQWLL0tCIZ8DUqmIaB+nlyyz7y6dKmfp+OnB/B?=
 =?us-ascii?Q?xwBjVLLrw/M29LB4+1ZMhYsxJ+uss1x6G7f8mMvrnTz/4wLzzKdAhrE3xMMf?=
 =?us-ascii?Q?ulhaabOCOmj7uj6QKBXvwzfo8vkQ0gB0IviwE+bNryGdXNnWtgVV1PUeN1UV?=
 =?us-ascii?Q?F2Ym5oPR5r5dgk4/+0nUhoyZIlBarL8Pln/YdBKbWEhwe14uwD/GWVfkZDMe?=
 =?us-ascii?Q?992Y7GkAJ7H9nv5aAkaFB9mSrwC9hZA1Oot8E/LsYJNg4T3KdrLRKyMnbxHK?=
 =?us-ascii?Q?vkFIFcn+fSEQgIpGxNMPegYJRGy4jnTV6WhmZc1d5T5KoHaE/jkRXIDztECQ?=
 =?us-ascii?Q?dSr9WmSmfxs3O3MJxU8cqDFhFg0MaWY9KM31g7pVKIffAXa9s18OIjpzd69l?=
 =?us-ascii?Q?lKB0Acek5Q7dBGf9XcI+aFHfX1gm49xVGm2beN6AaTIOR1CarhX4e5f4ZuY5?=
 =?us-ascii?Q?2241O8400QjQ+UQA2cN6NQqAWO7NvfaM2dTbuH5YKztlYUy1yJhLu81zddIL?=
 =?us-ascii?Q?wp8474qZJz7H5FlP0JMDgqDXNXyftjKCGxNaBOSZe56dQd423VP6H7aGQsc3?=
 =?us-ascii?Q?UQrGmYMgbj69SfWRgZUZc08j/HFXvmO1DSi4jUzz1Yl/rCyYmriA7ofTjELm?=
 =?us-ascii?Q?sgmpqTpCpwsPs7iQ2FaEebgcDM8dlTz0J5xwkoeYWDJg9ewuUkLoa/GqgGqZ?=
 =?us-ascii?Q?Ze42E7Eq4KF0HaaP8JJdSaVg9NPxYTLvYivxjEcUrN8vUpfyPZ+T7j5V5Wjf?=
 =?us-ascii?Q?j2nvk296G7v+BGtixGN/TdKyAEFqxE253tI5jOaq6cQnOcvrlRWa1GB08Ewb?=
 =?us-ascii?Q?abeUX/dPU9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6615deb9-04b6-4d8a-7349-08da07ba7ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 02:04:41.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGmjSotoMsB5RdLFDBowZf4IiLUAo3OHrMeXbj6YOAWC7HPhzXwMth3sRNilKU5lGM5EDedI/ZOi5dFZy8HNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Wednesday, March 16, 2022 3:08 PM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org; rdunlap@infradead.org
> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>;
> Zhang, Tianfei <tianfei.zhang@intel.com>
> Subject: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> In OFS, each PR slot (AFU) has one port device which include Port
> control, Port user clock control and Port errors. In legacy model,
> the AFU MMIO space was connected with Port device, so from port
> device point of view, there is a bar space associated with this
> port device. But in "Multiple VFs per PR slot" model, the AFU MMIO
> space was not connected with Port device. The BarID (3bits field) in
> PORTn_OFFSET register indicates which PCI bar space associated with
> this port device, the value 0b111 (FME_HDR_NO_PORT_BAR) means that
> no PCI bar for this port device.

The commit message is not matching the change, it's not related to AFU...

Current usage (FME DFL and PORT DFL are not linked together)

FME DFL=20
PORT DFL (located by FME's PORTn_OFFSET register, BAR + offset)

Your proposed new usage is (FME DFL and PORT DFL are linked together)

FME DFL -> PORT DFL
So FME's PORTn_OFFSET can be marked, then driver could skip it.

Is my understanding correct? If yes, please update your title and commit
message, and add some comments in code as well.

Again, the change you did in dfl core code, is not only impacting your
OFS device, but also future DFL devices, it's an extension to DFL.

Thanks
Hao

>=20
> ---
> v3: add PCI bar number checking with PCI_STD_NUM_BARS.
> v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 7 +++++++
>  drivers/fpga/dfl.h     | 1 +
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4d68719e608f..2e9abeca3625 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -258,6 +258,13 @@ static int find_dfls_by_default(struct pci_dev *pcid=
ev,
>  			 */
>  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar >=3D PCI_STD_NUM_BARS ||
> +			    bar =3D=3D FME_HDR_NO_PORT_BAR) {
> +				dev_dbg(&pcidev->dev, "skipping port without
> local BAR space %d\n",
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

