Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2BF577BE4
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 08:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiGRGqp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGRGqo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 02:46:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5415A3A;
        Sun, 17 Jul 2022 23:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4QBzGeOH2Wt8lypruqxoILGJEQm0aGwY2mBCoHRsZjGmFff3mz2pZGUkNHpNamSByJAA+OkAk8bO0zDEy2sC4hQrhH/uDeWeABng0E56l7pNaejRGTNJY06xXoVfKupd9KjMFUCLlux0PTE2R/q3paBXaFYgxjAa0CQ0xCj2sfnpqfM7UdOZrhSUi7b4Z0Gi99mSnbJNU1GzvX+i4CnNKodt9NY2r/eIrI5WZAyTDpyzE3GFkYGzW4eQSSZmhhBx1gTCG8xeUahvjDCinO9DcYTAq3LWj37eY6xrTXDj3O0gAEoNelo1U/+HnbrYaIv4gbO01f7xX7m7o21o08l0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxWMWtmOVrzTxlUPUZqJFz1DP3W5fsHSnWVFFF1kB8o=;
 b=hxiZOwj0J2c7VNFaQuxIfxmghbRnPKuxML2U4vXgeJiVvBSj553gMyQsTA+koT9DqGEBLRKNmI24PCfxQglYEnDiH0449XAmz4yjB5k4CTMxkzEiu8HIPTSk1CBC6/gw8cNMoFkPwYnCXb7O8myUSCFt9/rBDOKGHuH7XqqVsmfecsHa5qOAMJE/58y4WA77SBeovp+MyEUdnz7OLm+kgg2V16QtvVcfImQszZL7a8yDpG7M/75OdNpu3IiJq2jy/aTVSR0e4CXpwFAQAuVwSJNKLvPdorBODTP6bL4RjaR3zY474dWXcJgMtWeoHxy7rrXyiUR0zQTOWEOXZmArKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxWMWtmOVrzTxlUPUZqJFz1DP3W5fsHSnWVFFF1kB8o=;
 b=JzlFT/5vgWhlc6wL5ph5rQSmb0FSzlg+L34Eu7uy298azdN8f+7d+20PJH0A7mTlE51rDw59N/wNFweY6J8VakgpPMsw5SHYgaWRkxgBiJ7n5sqjPqbGmE+zLVwTnnNf3eOthMVihCYsv23EMEDIdFBt9kjLrAlkGADf2F9TF/E=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by BN8PR12MB4977.namprd12.prod.outlook.com (2603:10b6:408:a4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 06:46:32 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 06:46:32 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Xu Yilun <yilun.xu@intel.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git@xilinx.com" <git@xilinx.com>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
 property
Thread-Topic: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
 property
Thread-Index: AQHYbqt35NhisV9VlE6ddTAo4lgdma1e8XeAgCUOw+A=
Date:   Mon, 18 Jul 2022 06:46:32 +0000
Message-ID: <DM6PR12MB39937A19AE147CD9105C8D52CD8C9@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-3-nava.manne@xilinx.com>
 <20220624162815.GA2142910@yilunxu-OptiPlex-7050>
In-Reply-To: <20220624162815.GA2142910@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b33398-ae17-4f9a-858b-08da6889403b
x-ms-traffictypediagnostic: BN8PR12MB4977:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ptgvj1cwvp3Fi69yxkmMBPZvKsE0x0vV28eiXy95nTB0uhSUqMFYyD3tPOE5Mi+XAsTqDigAzyUs/9TuC5cobPhDSdWBx7o45VEm78gV7ZFo6lI7M//3ZPW1+AhDKLJve2YQ3ezKt2Nd8BsapnY3Wn7kFpx+zTJWN9WDXPk6lSlMfCDGu+Wyg5K9RYnB24UOuJaTEhoJoYMzCaEjkIL5cQmVLv4mtIPkfxFhyRVL6sZPW0wg7QIQAevBsn+tAaGy9yGD6U6BndVtA4ZAf0Vm7xdMTWbspMtudPRBhkgI/VQ/6yAvFXk5QLM2WH9ZrUGZ6JahkuQnflP//X34XIxB2e3GpTgI7qQxhUGcjqKDpFe3axKpWOnuJeiANL/vo+JOwda87PrSqZn0PQ+Vl9P9b+VdVVKduV+Luh71Zfj1vC/WiV3IZCouofspFrIQ2VJrISU37VRVd+vOSrybAQ2MtgjpAwdJ40xvK3ImP68TKZ87wCz3w6GAWeWd1GkELLF8Fw/VZa1xvsQEzfxccUAWmzcTD1NoM9FzmNGLfQ2MW3uJKoh1DeylE64vPu0/tD7zzliLMz+mZ9u/mca0EiYhnaiNt7pHd7BcRPoTyymG9YX3LbklgGxBdEwgHJq6LMxtMZfJR/AmywZzlID2MJ+ikit2SDLWIEQonMJuOSOJrW1jKQPHT5PmZMftejf5wxWgfA1d2+6jxrtcYe/yOBgJ1oU9Ch2EUfgtF/KfMxdtOSbix0kLdLZOEXHXI3LZfi9/QmotCzheRR1f3tgW/SgXTIP+AseQRaWVhM6oBJQheIe8PsRZWgovOMBRikW9YDrj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(316002)(52536014)(8936002)(86362001)(38100700002)(7416002)(55016003)(76116006)(66946007)(66556008)(66446008)(8676002)(4326008)(66476007)(64756008)(7696005)(83380400001)(6506007)(53546011)(5660300002)(38070700005)(41300700001)(54906003)(186003)(9686003)(26005)(110136005)(122000001)(478600001)(2906002)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xCi2UZWNgG25I1RrF9WG1iyfZemKIRmqAt6JZzGKcQNcLWeM1fa8DLPkY+VK?=
 =?us-ascii?Q?J0rZus8uFdaX5MCXe5aPbZeoiv8YIu+0JqnjUMXntfB2I89aAObTMvFcf0Fi?=
 =?us-ascii?Q?HwVX1ez5mtA9Pwvm9DDmB0QXJRRkc2zow72cymFaZoT2w95iEePUu5yuKFUS?=
 =?us-ascii?Q?omz0wsZ2w+klbx2v7yLGoBw5ModwtszznxCMFudbS3pkCds4dMxChSttrmAA?=
 =?us-ascii?Q?u+4zDxX/CYpE3D/mzfayuUctUIrHzYfFAZTsbo1ANxwXE6yXlzz6yyA27UOO?=
 =?us-ascii?Q?WdeLrmrCDyaRiUJPhA2a+OMDALopFSgHFnDKe3zwANp0Z94/sabCmbAG8Kwo?=
 =?us-ascii?Q?iRDTiHlIzUkHhErK+5oAa+iS9a1OZ/qcuZQl1m6dXI+WogJS3+QsmHMzScWR?=
 =?us-ascii?Q?xWsyUM2M8IEF3wOrf+gZs0RlyOgPXv7t786uqmhua7CIZyWAJSwa+retou63?=
 =?us-ascii?Q?wGN44U+Ww53yCL+mWHpweEIVkWVJdnwxLDwUzHYfvC6TrgpKlSxQ8WDLgJpQ?=
 =?us-ascii?Q?useKYOBjp7tfsL3HeqYRc+o4Hpkzt8XX1oUT/5tJCsjF4tbNg6C3GafwWfyY?=
 =?us-ascii?Q?gXvjBWtQ5BwL7ZU4t4RS5jKdqYr1xZwyjfAGAzMu9IYHdMuiYGlxRmw3KjXj?=
 =?us-ascii?Q?Tw18aDo11IvM8q79rFUgW3yKDGuWMooSU+qBgQKKGW4Uulh6MeqI2dPniy3N?=
 =?us-ascii?Q?Rqk3I5Yf4LFqJR+xCCt+jUSmwNcdb69Dj6kg8XitzR2A02elsnxA5+iVvpH8?=
 =?us-ascii?Q?S42Gdh86tVLAx/HzDZlIjGLqe1wS2/zAsGkLcmIUiIk3krD98JRg68IyAp4R?=
 =?us-ascii?Q?NLXzj3Yz/DxQaGJ6umqlAMsMYqR7zMjW5TA6E/AQyFF6QB62HCrtu7GB+PX4?=
 =?us-ascii?Q?ukKfEcgtNPn6p29r+Coqe7GpQ/3hf+QnZuehVeo+/1rvSdbKGziq+yq3Tk0E?=
 =?us-ascii?Q?Hj4WgH6YdbYo4P8m4ynWMyTGpfcdwxb7ph42CY+IEPdW3Fanea6yapYMXhif?=
 =?us-ascii?Q?XsDLv1o7j4eJH2dFsWY5gOm7fXi9aLG+PoxYAgYyKHxw9802gRC0pUcPa66X?=
 =?us-ascii?Q?dZo0nRpFk26qIK2+JDdC1ewQ6/Bq4i3vS5+UMlTT79Pi4cd0pWTMnObtkPJ+?=
 =?us-ascii?Q?Whp2CLs28TCR3Gcq/fybJWZ5GE6jX5iOhSkwu58rtotjOqBX42LD2FxRD8FT?=
 =?us-ascii?Q?rO91GNfjGx3/sxocjZ+cTvoFBN+U9xzHNAIg2t8GYq3VgO477hZtqpfIdCMO?=
 =?us-ascii?Q?dY0yjA7TLsL0HnCMf9Si3nYoInORiue4ZujQCekluQWdbUKdW+flfnYDZTn/?=
 =?us-ascii?Q?ePihZKlecLCstsMj8/mc0HXxVuTgo6zTy7IBm/QsV94arMl4dQMvYb7ol3Lu?=
 =?us-ascii?Q?f2f3dBdOAsft0INzN2eN0P8SHmfu+Pp01ISjR5cwh1HTzg99r/9oASt+F4gw?=
 =?us-ascii?Q?V62Vcp6X6MDhk/cvrYhpkmdHXBkvcgNeZZw+U8wRgIw8VIucjeZ+5mIe6xj1?=
 =?us-ascii?Q?6/gSfuq6CxEM2+boxtxPi55jcj5U/V+8pM3ivCgxnyzsgpXCrFhGVcfHK++7?=
 =?us-ascii?Q?2wlKEgfGb/q4XbdvJRo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b33398-ae17-4f9a-858b-08da6889403b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 06:46:32.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jyOdgwClSRrV2fUF8qpuAz74iV0xXawPQjwPCIKzX0ymSRkiSkqR6HUtbwqN0EBf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
> Sent: Friday, June 24, 2022 9:58 PM
> To: Nava kishore Manne <nava.manne@xilinx.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> michal.simek@xilinx.com; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git@xilinx.com; Rob Herring <robh@kernel.org>
> Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
> property
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On Mon, May 23, 2022 at 07:15:16PM +0530, Nava kishore Manne wrote:
> > Add fpga-region 'power-domains' property to allow to handle the
> > FPGA/PL power domains.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes for v2:
> >               - Updated power-domains description.
> >
> >  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > index 7d3515264838..f299c3749505 100644
> > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > @@ -196,6 +196,20 @@ Optional properties:
> >  - config-complete-timeout-us : The maximum time in microseconds time
> for the
> >       FPGA to go to operating mode after the region has been programmed=
.
> >  - child nodes : devices in the FPGA after programming.
> > +- power-domains : A phandle and power domain specifier pair to the
> power domain
> > +     which is responsible for turning on/off the power to the FPGA/PL
> region.
>=20
> Could you help explain what is PL?
>=20
> > +Example:
> > +     fpga_full: fpga-full {
> > +                compatible =3D "fpga-region";
> > +                fpga-mgr =3D <&zynqmp_pcap>;
> > +                #address-cells =3D <2>;
> > +                #size-cells =3D <2>;
> > +                ranges;
> > +                power-domains =3D <&zynqmp_firmware PL_PD>;
> > +        };
> > +
> > +     The PL_PD power domain will be turned on before loading the
> > +bitstream and turned off while removing/unloading the bitstream using
> overlays.
>=20
> I think the single power-domain may not cover some use cases that of-fpga=
-
> region driver supports.

I am not sure which use case you are talking about. Can you please point me=
 the exact use case here?
 =20
> It is possible there are already devices in fpga-region
> for static OF tree, or an overlay with no 'firmware-name' but 'external-f=
pga-
> config'. In these cases power domains may still be needed, is it?
>

It's an optional property user can decide whether he needs this support or =
not for 'external-fpga-config
Use case.=20

> Another case is the fpga-region may need multiple power domains?
>

In our use case full region and relevant partial regions have different pow=
er domains and
this patch is capable of handle different power domain regions (full and pa=
rtial regions)
=20
> Since the of-fpga-region driver is a generic fpga-region driver, we may
> investigate more for a compatible power-domain solution.
>=20

Please share your thoughts here we will try to align with it.

Regards,
Navakishore.
