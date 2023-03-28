Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F36CBB2A
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Mar 2023 11:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjC1JfS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Mar 2023 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjC1Je7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Mar 2023 05:34:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA627D8E;
        Tue, 28 Mar 2023 02:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzgX3tgSxIdKYJDrHFqp/Sahny0q81O2eaTs6QWK1jKjMlEDV7AQ7/1SfbJF+hQGFUnhOtLYXoZOxxy0BtlfQS9A0PtJ2E46uutNuxsy7uHyn0h0a8RnbpngpfinsnuMKq/w2kU601SvhXxbeHgIqEQkCLiK8w41/lWGV26kfokK6oHzAkt7qcc9AL90Gb6Pjhn3ZtAa92uJv+In4BtNTlcDAvwyeYuPWne6h1F1An6mJazL1IbqO/SSZJYyv1Q8xBUX/6VNFX+arcbJ2dDZZEvoDNppPQ1olFITIi7tpdVuxxujlb2REJ4q245eRdumbVi/RNbKSJP142UsLjPBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t0mp9YMdXyt8QUYE2sBUI2oZIEww6mb8pUyMgVYMYA=;
 b=VzF0kP/cPhRJwXgnCjnzZE28G5uOE6QtQLS726FCLKoyjMLrv22GLRB6phqLC0+pZUscDG2FLnPEFDmdth4ciCcceXA/RZXPp5bs7VYWWI3RDsIO+SawZj2jQBbm7+SObPdm+PMI+N3gLHfsCinXe9+xwuYpiX8aipawAFt6nXasftbGRnc+YlluQOG2i5OT8p4X8d8LwC5IkjnmLLyU8D1Sf1ok6a+7B8P3ewrDhytLjTMI6+Tstb10vh6Cht+ffkHJHxOMZLfuG0gvfRv9kakIpUuGAlerY2JRugAsIbSLoFUg4wjDiwdhrBg1EjsonR1z9hfvs+cft/W3cPZuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t0mp9YMdXyt8QUYE2sBUI2oZIEww6mb8pUyMgVYMYA=;
 b=MQ92XNKcUsG324oNalE6qFu4Vz09c/y5DhZC3CvKmL7OZaVOUPtTOBN32N+lymVTsV696O3hm0st6QyRq7yQPq8Wob+KRyq91LpX6vkklK1jlDR3FwLIUnsu410R1ROeGnM3Bvgny41FV4KugQG1nVjRR4/yArRuB14M371hkdM=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 09:33:17 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::2e8d:fc35:65dd:e12b]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::2e8d:fc35:65dd:e12b%4]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 09:33:17 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fpga: zynqmp: Make word align the configuration data
Thread-Topic: [PATCH] fpga: zynqmp: Make word align the configuration data
Thread-Index: AQHZWXuR3rJJ/x7nykeWgtqrbf+iH68P12AA
Date:   Tue, 28 Mar 2023 09:33:17 +0000
Message-ID: <DM6PR12MB399339FED1FDAFEBD0D3A566CD889@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20230314094222.66916-1-nava.kishore.manne@amd.com>
 <ZBWDhAaavbrehAjh@yilunxu-OptiPlex-7050>
In-Reply-To: <ZBWDhAaavbrehAjh@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|DM4PR12MB7669:EE_
x-ms-office365-filtering-correlation-id: 615ae821-d3ce-4ef8-f086-08db2f6f762a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0nVA24DsgYIVPk/XADxANdFPMnfxLv1QnRGl8CpA9lolSeL07PWsy8BXOTFrYGDtiXnrYVSViD0bJ3oZ2tyIilIqXQ/nQIO8o6u60704PJpU6q/X3BskDQ96hkvYw4ByaruVIIMHsWxChX2NomMB0FPS+nyOnrX41BqPlgy9EMeNBQgExpsSXn429DovJ2CACG2weayxDyxU3539CIfLA01D4nyPR2gTNO0xRLck/e6/unS5vO/IL/RAH78aoS3crI2/1B7KfTCaYyoeH5iuNow0VyJKkBF+8buzQl3rrLWp2ZzeChZHrCQ+G7Tr4Xj55R7FTFMDZ5QiH9hWJwlGqzim+cBwaYHUwqaIzQOzbBMYT/oSND8uCkUVoxYeLqip49tNYv8GZEwC7tWfM4jZKyRksOo8sDPEnL7zsuwM1cL3npkYC2wQl7i7gXMX5+CPEPzEwnUzb+rFpGOZ7NSHO0QwPob332Vbbu3pQ5Gs7CPS260W+s3TZlvuQRC8NzUKmtId9tkW6JTrXrd6ARoh55AiZ68piFaWbPpQ6E//vZHmhHMGVVNzZORR8xElFzOYBekrDgTv0GtZB4BX17h8sR41VtNEvE3Edqwsir8Zc1WtnDY4le57Qexb6HTLxEj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(122000001)(38100700002)(55016003)(33656002)(86362001)(38070700005)(2906002)(4326008)(186003)(71200400001)(478600001)(9686003)(26005)(53546011)(5660300002)(8936002)(7696005)(52536014)(41300700001)(6506007)(316002)(64756008)(8676002)(66446008)(6916009)(66556008)(66946007)(66476007)(83380400001)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oY/4TDj9RTpBwcwnIMeF6Ezjjn6jLIdHz6UKKw99L+mHijs24MJlPWRUtCsv?=
 =?us-ascii?Q?CQOS5V6hmNadqGamXvcH2NMv678XZK/EmuWdulCU98mfoJ+kKa6dQdxwwNpn?=
 =?us-ascii?Q?FFKrVGvZ84vtLfhtQY/ssfc8r5bFcQ1cJVFjoaxFYoguQJW5rgEMCzKJwn6D?=
 =?us-ascii?Q?nGp0xzW6reMlZnYVvzy9CaVeQO8tIuFw5D+WTVHqBoCkGH6llpHm+p/5GY7P?=
 =?us-ascii?Q?LrvQrx98VcNz6xG+23ityIL0et6EV4Z+nO6ngDBl/Yhbbse2fwXQEzBDS3RK?=
 =?us-ascii?Q?eNdRtA7kLv97H94FGkF35N30WQg5U3egaKh7SN6xnfsxtSwmR0Vb6JVbORSs?=
 =?us-ascii?Q?rLeJiDiqJKrz499K10t/eHy7uqk31gFT813T2SYeyrWPT2vRth9w5xjj3eBk?=
 =?us-ascii?Q?5h6HbLZQux+u+DLV10IIE8olQ4oKtQRtVaMtWvpMwLx/GKU03N03+9C4vw/9?=
 =?us-ascii?Q?ZE/C286Vwc8lFxG5igLGGunLu+KKvfUA0BO7OYR+hw4GZ7LHXu4foBhDrtI2?=
 =?us-ascii?Q?g6nY+yywzGq5e5cUbdW59bO8XHFLpbM6+zRK8w1mjxVZJeHECvTGriC7ebzs?=
 =?us-ascii?Q?uIWl/QECwYTuXSfUB/JY48TaOBaR/djdxvJmmbWZMd0YKeiLIRcxOuI8KOSx?=
 =?us-ascii?Q?p3E0T38/rEOYArI4UiXg73JpZsGPbKD5biYFuGLFVQLaOUbatKZNNhrZERdU?=
 =?us-ascii?Q?WukLEinrXDOcORlJgyyQL8ibauqIcKaxMtkcesuj+106obskZI51dG1zRqlC?=
 =?us-ascii?Q?KzE9CBplTPZsrBq08x84C91K2BRJC2IvVgEB7bYmYknSfSYIPra1KBqukSE4?=
 =?us-ascii?Q?QO7wVj4ed4BjZYmbqujjPVMPhVK3jSttqz2ROtsQKCPOP114XqtF0vU2h94h?=
 =?us-ascii?Q?jxbfLS20zspcBmBPGQzNo4/+YHjrhVizIy1YVVG3SHFfhzIgvjngnWfStUSO?=
 =?us-ascii?Q?rD3kqSb02tPm/41TJ7tuSeoYWOaXFYiZGxVPx/2Yp4hJ8+W+P+AMXkpdhoC+?=
 =?us-ascii?Q?DpwOkQU/2n+jFmf5B8smII5ocjAR+czHHdnuwqqm5efjTIQkYbaPngjYh16n?=
 =?us-ascii?Q?HOwEZh426aYOQPv/pIpk9EuhSiSFY+99tTPARNNZOFo7FHtkaJFkgTmCXHhp?=
 =?us-ascii?Q?V/JhLQR5xrUjLxPFAG19kKffn6EzTIhE/Ep5vqoQjiuYFl1EJCDhwNj3wi7N?=
 =?us-ascii?Q?4TSDoqqSOjUPRywPcQfAKGlnFJrK5h05W284YK78likhWHpDS7ubX6cLa1Lt?=
 =?us-ascii?Q?HsRuTj7YUXGAgfOLmhSVJWRklCf9EWh3LFHZUjQaSPEzL8f4Z+oPP2xXhYir?=
 =?us-ascii?Q?94BANHXx5GEYWTboM53wAVhc8T5A/6phTB9eHGqf7CJ/uRymMJppFuTQBOA/?=
 =?us-ascii?Q?y1i2TMzu472wQNUY0/1JGrIyFQNXFOImH4+vYjIB83FAaZeaNoT207BaLXI6?=
 =?us-ascii?Q?l6B4YfXsyw7jGuc0V/4BPbTjVqnk8hLpuXTp2Tsx4hqdTCTCMpH3VgpEYc/z?=
 =?us-ascii?Q?1t3xsg35J5V9Yj1cqtoj0TqngJ6H2KnMDbkfCJvzL2uY9tN2pFxQoi9wKDLQ?=
 =?us-ascii?Q?J/2JeEP6qR9wgoZZHPE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615ae821-d3ce-4ef8-f086-08db2f6f762a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 09:33:17.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O56V9JrAxkaiT20i6HzJmiNQ9vdGOn9gOlKqgD6+n+YceD1DxVJvkX+azYiGgLO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

	Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Saturday, March 18, 2023 2:55 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> michal.simek@xilinx.com; linux-fpga@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] fpga: zynqmp: Make word align the configuration data
>=20
> On 2023-03-14 at 15:12:22 +0530, Nava kishore Manne wrote:
> > To avoid unwanted copies at firmware(PMUFW) this patch provides a fix
>=20
> The copy happens in firmware? Please help briefly describe the firmware
> operations in commit message.
>=20

Yes, If the firmware receives unaligned Bitstream file from Linux to make t=
hem align
it will do one more copy at firmware and this copy takes much time as firmw=
are code
runs on microblaze(32-bit processor and runs at lower frequency).=20
So, we suggested the users to handle the alignment issues at top layers(Bef=
ore submitting request to the firmware).

Will update the description in v2.

> > to align programmable logic(PL) configuration data if the data is not
> > word-aligned. To align the configuration data this patch adds a few
> > padding bytes and these additional padding bytes will not create any
> > functional impact on the PL configuration.
> >
> > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > ---
> >  drivers/fpga/zynqmp-fpga.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index c60f20949c47..70a12dc6e15c 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -15,6 +15,9 @@
> >  /* Constant Definitions */
> >  #define IXR_FPGA_DONE_MASK	BIT(3)
> >
> > +#define DUMMY_PAD_BYTE		0xFF
> > +#define FPGA_WORD_SIZE		4
> > +
> >  /**
> >   * struct zynqmp_fpga_priv - Private data structure
> >   * @dev:	Device data structure
> > @@ -41,18 +44,26 @@ static int zynqmp_fpga_ops_write(struct
> fpga_manager *mgr,
> >  				 const char *buf, size_t size)
> >  {
> >  	struct zynqmp_fpga_priv *priv;
> > +	int word_align, ret, index;
> >  	dma_addr_t dma_addr;
> >  	u32 eemi_flags =3D 0;
> >  	char *kbuf;
> > -	int ret;
> >
> >  	priv =3D mgr->priv;
> > +	word_align =3D size % FPGA_WORD_SIZE;
> > +	if (word_align)
> > +		word_align =3D FPGA_WORD_SIZE - word_align;
> > +
> > +	size =3D size + word_align;
>=20
> Does the Macro ALIGN() help?
>=20

Will fix in v2.

> >
> >  	kbuf =3D dma_alloc_coherent(priv->dev, size, &dma_addr,
> GFP_KERNEL);
> >  	if (!kbuf)
> >  		return -ENOMEM;
> >
> > -	memcpy(kbuf, buf, size);
>=20
> This is historical, but why do the realloc & copy? Any better way?
>=20

Firmware internally uses the AXI DMA engine to transfer PL data from memory=
 to the device
and it supports only continues DMA-able memory access(It will not support s=
catter-gather memory access).
So, this extra copy is needed to copy the data from kernel memory(allocated=
 by the firmware subsystem using page allocators)
to continues DMA-able memory.
=20
> > +	for (index =3D 0; index < word_align; index++)
> > +		kbuf[index] =3D DUMMY_PAD_BYTE;
> > +
> > +	memcpy(&kbuf[index], buf, size - index);
>=20
> Generally I object to massive copy in fpga_manager_ops::write if not
> necessary. If there is an alignment requirement from HW, it should be
> noticed to the caller in some way, before the buffer is created.
>=20

Agree, we should find a way to support this kind of use cases.=20

Regards,
Navakishore.

