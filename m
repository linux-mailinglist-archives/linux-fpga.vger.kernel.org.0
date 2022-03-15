Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5AC4D9AA4
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Mar 2022 12:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiCOLt2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Mar 2022 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiCOLt2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Mar 2022 07:49:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8091FCF0;
        Tue, 15 Mar 2022 04:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3NBi4PY24Up4ydFE3ShTaIHa59A6vkCCe6GJLp8pwnwcMOHvzOQq8QFm8rG6wg35mboJRTcAfxryus6OmkMyryd+xohsMzTx8zs7IO4Mxiqvb4o1iALfwAl8Y6yaTUcZxffU4eetFchbn7b//0sPNAoP+1eKYWI/z2FHN6HNRf9N95UAuisHMBfIzGT1Tn2gRw/qFZ6/GLveazg0vJuCS6BlBvxJVQqpeMHMaZoaycyyib13kWGz80hi9w2Zf2nYf+DLjLp/MStZrt8t72RGEex7ono+gfppEF50CoEdS3PjpxIVnmIToRi41flkMCU4jkoqimDk1hKNryRBRDK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fOI7+G0by/tDJohB0PjrjlZFd64O+jKt0p5n/pnWP8=;
 b=oMJiqqXBFu0aRTOXW+lVUdTIIt22RvIx0RQ/P2Rbevnt6yV/JvHD9p0A7SY7D2UUU5s9cUI5hPJ5v8Jak1L71a83Q4ukrM49l8NjIu6JVDZJOvLrWE1cgTuApLiImbWXtdNtareib2CPtEHmpSw2HyRCZVrVTFvTh7LMv+bttu1Z/7Nlgq7NfVkFFoNUAanGUJekHXkHoudb4Tnv8P1fowMI6ZHH9EKifMm6ui9W9h6yHLckbFNIpDKlu2KkAvAsJEZ7OWEUSo8lub29BC6WD4caOqxLjH/ucPXhzjHq2kU/IipTJ1yvJ2HDNdA61CECNdD8pYYyV6yGkaJSoBxhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fOI7+G0by/tDJohB0PjrjlZFd64O+jKt0p5n/pnWP8=;
 b=Z4lkOi3IyDnQ59mK0+XQ6gaqyzP6VH9LjCPbMSj6YwU6Lt4O5Gfvkir3NDA8IQ3zvh8+MZdzahIA5G4X4pO+uGuP7SGD9Ib8gIkSlnB1Yodhd7ZIAlEzPkcDfwEXd1bk2GpsrDJQ2IOSfObRu1V5kKzVd2xbfuZVBTKTweacuoQ=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BYAPR02MB5927.namprd02.prod.outlook.com (2603:10b6:a03:121::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 11:48:12 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 11:48:11 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/6] fpga: zynqmp: Initialized variables before using it
Thread-Topic: [PATCH 2/6] fpga: zynqmp: Initialized variables before using it
Thread-Index: AQHYMtFNadCZe0VWu0OEcc9wpwDlOKy6QtkAgAYbAYA=
Date:   Tue, 15 Mar 2022 11:48:11 +0000
Message-ID: <SN6PR02MB4576FB4490F96E593E09D4B9C2109@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
 <20220308094519.1816649-3-nava.manne@xilinx.com>
 <20220311142814.GA97487@yilunxu-OptiPlex-7050>
In-Reply-To: <20220311142814.GA97487@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95546812-3b28-4e9a-4459-08da0679aece
x-ms-traffictypediagnostic: BYAPR02MB5927:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB592759A551C46F7FAAB81F1BC2109@BYAPR02MB5927.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKfWQzuMXN6hWSaHTGTn9/q1PAqnE9nsttITxATwU8MkfQrk+9Mc3bngF1MgyZZYOJn3mRyvlSrCOF0LkxL0fgP1FtDi4XfJ69m7cljoTwLz4atAhcWHDVVILNiQ/IZp/BiThf356Z2Ush5G4M5KiIyLsbwzOxqcHoJrh8zSNpGeKh861SBXsHrwQrt6X6xQLEbmxyjd15rxmMUK51f3HVmcHsyBrSPrd3aOuHOdkOt9HKFKNz8Z0YRTOm9aKj+JgzA+zV+dC9Y70NdEyFH1o2AdSvgZ8hDYKf7vuVGoF5jpJtzY8oMfIhuYO93rNM1tN2foEjUglyBzByi7duPaoTbKQnAf0KnwJff1PFjQy7o+IsrdsVNiHBwiVqvTM2IHvXVKyWDpoTU9QIzBYsaQ1dHkqQ4v6fRc7oRye2i8gqv7y3fSIDwKo807HAHu+eQFKl0/Y2+lfXC0TuEDsomIBNS+guH5aVTthrrgU0GkRdbpLCHYZjd5plxzwyPjlgnVteLrGpeUEXsH+PZ+hw7UF202nlYLYzT5BL4aou3vbxTV+qDLofIrpUSukP2HGXpiNpHTxEDiOLYm7OIRu6bABVPyLFrF0Hcbwy5hx8V3+QO+L7DIQM2UK2Rt9DplZTHt2MXBMOyfGZkdnCZxpt9n14/LXLDRJO5cGPFfrMlwxcb7ryAmV+KsOxKJNWvFTgQQIYIl0HLksZ1ovSc4uPwmNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(2906002)(33656002)(5660300002)(8936002)(9686003)(7696005)(53546011)(6506007)(71200400001)(83380400001)(508600001)(122000001)(38070700005)(86362001)(52536014)(76116006)(54906003)(6916009)(316002)(55016003)(38100700002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nwy1JlnjNyIjlFKNGPva3wau1+FL62NlZvEcwoEUVzd0L4XVAUg5ipy7jr1i?=
 =?us-ascii?Q?ziPQ9UzQUqjEzaOHCJy+hStRRD/km4xE1WeAatPDnxrwO5Gf6tl+lPtfFt8W?=
 =?us-ascii?Q?jO75fK3J3lbzEDCeaxvYc2w7avYydfpY92uorEJVrhUiOP1cpJ1+0XEAHi/Y?=
 =?us-ascii?Q?pUKtegfGmgTDXWq+UeanFBVD9QEYSTI2iFI8u9rnxFE4T1/W7lJEZvHn2w1Q?=
 =?us-ascii?Q?/6LWfoM9Kq3wxqs13LMCRyAhD+1rcJ8c6mnDMjU9Xx+uJ9EsDDfiWB+rUCnQ?=
 =?us-ascii?Q?6gcmfc2upAQhP+4/jB6dZtDGRZnWC6BqvNh91+OnwzUlXzfUr7TcuIfQtwkr?=
 =?us-ascii?Q?GaUy0iBdPlzklu1MeHFJhYggsGlK/jNPwno/3uJXgI7jCVIfNQMFha/X6Mby?=
 =?us-ascii?Q?l4cT9LLgUxV4gliKJykcbRtXHVMHMuPz5S+piNqCW2vSCtOU8bLOqs0arnTq?=
 =?us-ascii?Q?mgehGZy7EwqfgWBBm9CsR2SG4bojvUel/t+xAgAxmn4B+UFn3grjjxVubuaj?=
 =?us-ascii?Q?V7yAct3jv0DxEtseSiwqcYBYCHgOY2ccB8u7nMWW+KttI7NY214hwmt7Nn7a?=
 =?us-ascii?Q?r/ClllXoLv+sruhRs42x/8O/lYByXDPLmbWcU+9AD9eIJMkboBN2mM0AwMhe?=
 =?us-ascii?Q?kxyoGEpgljm74sk06xkj8ztMWNPI4iyHFuPWXR4Nd/Gisd+pAdxBJIVBcoR3?=
 =?us-ascii?Q?zexMr31M/VanQgerd0MgyswKFHHyajaa0UNtfOfVyz7Q8HZdr8qlQvUcTb36?=
 =?us-ascii?Q?BzSK8+x3kCkWSiel7f/aif1+QJnUM1c6Dmg+WQOkymUyS/EF9duuRseoR35r?=
 =?us-ascii?Q?eFhChVWR3grH4gIrvTWr/v1J/Yx5TSmlz02AHBRhZldr4LyhRV9fi9rTS2IP?=
 =?us-ascii?Q?hlx7RhlzowxYYNBENZ/TI5ZxPYSwsir4mkALx7tgepBdpm9jqMJBG6rF8T0u?=
 =?us-ascii?Q?Xozw3sveKCyrpK1WcgKeubGWjf7vlGRP9ohoCdgAANpn5N0/F0gM/mn2RpBy?=
 =?us-ascii?Q?y63B05M7ygTgFMQSCiaHFYshtlCrFpSLrEYG2BwrTKJfYQBlB2Q41ehdH7Su?=
 =?us-ascii?Q?WU9g9AmTO4SBpZ8RIZSDjgyVUGWb0+NwuhclWY7hmNiHrbXvo5O8UQeTd/Y2?=
 =?us-ascii?Q?Sqn82tJQtYjSYfJBxNItAdtYHiSbHXFimIjCMdFCcBhr4D49uupmTVo87yza?=
 =?us-ascii?Q?FDKYc8wZ9uwVJP/+D9S4AN/uo+hhFDqLa1CzvFlXcfLQkclGCLMlhvBCokmz?=
 =?us-ascii?Q?Z246cjR1uhCgXjv/03989j1EO2kou8EtEzQzY7iIfzq2kNDzaBTOoIlAaQz+?=
 =?us-ascii?Q?dGUl4RmIhew+f2OBIR7tIaZS/PBnj0NF54TAk9FBnEU45tp+5HNobIVsgsvQ?=
 =?us-ascii?Q?HCLfntnE8zmlCR3GCY/Xg+v4oK3k/yfUUgiBvJfd0sSPy6mwO3BKFjT5Q7HV?=
 =?us-ascii?Q?hE2lHJLSDUM8CfARrZG+EAxU8MU/6rEP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95546812-3b28-4e9a-4459-08da0679aece
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 11:48:11.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2EigmYUce0mqmT53vq1FA1zEIZdTEInu4S7xhaT9A86tRTW4Nb5xdRLuqKavLbYxtJvXZYEreUyyvOHPY2v7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5927
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Friday, March 11, 2022 7:58 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/6] fpga: zynqmp: Initialized variables before using=
 it
>=20
> On Tue, Mar 08, 2022 at 03:15:15PM +0530, Nava kishore Manne wrote:
> > This patch initialized variables with the proper value.
> > Addresses-Coverity: "uninit_use: Using uninitialized value"
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/zynqmp-fpga.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index c60f20949c47..e931d69819a7 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -41,7 +41,7 @@ static int zynqmp_fpga_ops_write(struct
> fpga_manager *mgr,
> >  				 const char *buf, size_t size)
> >  {
> >  	struct zynqmp_fpga_priv *priv;
> > -	dma_addr_t dma_addr;
> > +	dma_addr_t dma_addr =3D 0;
>=20
> The first use of this variable is as an output parameter:
>=20
> 	kbuf =3D dma_alloc_coherent(priv->dev, size, &dma_addr,
> GFP_KERNEL);
>=20
> So I don't think it needs to be initialized as 0.
>=20

This issue is found by Coverity Scan, Whether this param is input/output th=
is fix will not impact the actual functionality.
In order to fix the issues reported by the Coverity tool, this fix is neede=
d.

Regards,
Navakishore.
