Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81F520CA3
	for <lists+linux-fpga@lfdr.de>; Tue, 10 May 2022 06:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiEJEWq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 May 2022 00:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiEJEVV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 May 2022 00:21:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64E199B25;
        Mon,  9 May 2022 21:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjMILifluA3+YCpFoUEGuSwU6KabiAlJU7ABmVyv/pz8QF+oWtcMHSqtXlfYwovFxBP2Si3MBOFnsvKsfZvNS6XLQ7WwFoUtBKLAAKKByJma01JI4T7PZGiAYNGv7H9FJXEW8MaI5TqLVzmJ4wEbJ4k5I7CuGnLPoiQr/nzZaEmHgZJ8azIW77t5kzVNjfyNz1kQ1jHXvt3XP3BMDAmrW6RHUeZaSxp6IiEZF0tKuka6406FnQCRzNJAju8hFN2koSGbFjtAA//IO+q13O3l1ARrd6r9HfCBTATgsUYVhLFFrEmz/1xiv9Ygkl2QW+XZtFB9fBMHLM79afzw+g8J6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPZ4hI3zs9XdRPwSAInu4g1p0RFahBXvIXtN731nrww=;
 b=DEnSRXGcf2PocKCAEto/9x/YCwizT8mei5+Zm0apryqigRn3pcgGopGQSZnsADK1ljqbLX436An2UTAlvBYrNH4wJ0mDgpBoYGUTpCcpUSxu2jVHAafUXCScTrkalkugoz5jXqHJDaOBAy6VRzJNM74S+PDl7gftBbF7QzaR9Ownwbv775zbPRosBgWi41CjUVEr09BDJ0JINPzzNCbfzCj7OD590/521D/Lw82/6ITpRPdMWTJ8T5Y0NhVvNgMRqzneTME74jnn/8AX4g20t5u8Ue/gw2UgQh2FLqhRs7qZIFU306oO5Bqj+TA6Jo5hUatgyCEUDYMX8Ex+ePlk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPZ4hI3zs9XdRPwSAInu4g1p0RFahBXvIXtN731nrww=;
 b=kfZsHsd88TPPL7UciyPotEkEb5ByCyIFGantINjt2lLaeUh7sPQN4CtxnNdmRoUwnRyJ62BiUFWqctQ67/WlDV1M+XkxC0j7gNQybCjhawMR0qf8Q7BzxbdOqPvgkZ/t+ZRzpBv8btJJ1YYSheuhAw+BpfnOE2oK3sDd5Q997Hw=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by DM5PR02MB3353.namprd02.prod.outlook.com (2603:10b6:4:65::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 04:16:48 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::3ca3:adb0:8f4b:c865]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::3ca3:adb0:8f4b:c865%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 04:16:48 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Thread-Topic: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Thread-Index: AQHYY536ULblJruqZk67DKEGAICzRq0WfaoAgABGQwCAAKzLIA==
Date:   Tue, 10 May 2022 04:16:48 +0000
Message-ID: <SN6PR02MB4576735D28AA50978B0D0FC1C2C99@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <YnkE8AbimDa7sfN8@kili>
 <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
 <20220509165526.GB470015@yilunxu-OptiPlex-7050>
In-Reply-To: <20220509165526.GB470015@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09f26ac1-865e-4bd2-5118-08da323be6dc
x-ms-traffictypediagnostic: DM5PR02MB3353:EE_
x-microsoft-antispam-prvs: <DM5PR02MB33531B8AC78E0FC3497B654EC2C99@DM5PR02MB3353.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPc0SmKSf+Cuy7mnueSWng1UPY5paeB98SOtM7wQNFwSDGl1ymW+w6O+/ij6Ib0qBFVamBQbHOoFQok/Te4uTBcYiY3IBgCekPWcR7kTNVnCpYojTCJuryoq1DNjxncqwryek8AMv4qtcEnn+IbSEzq8+KJyWAKHQJxQfZsOV3m+RZnKQqvOt36tHCCLSh0bNS73CEPUzPb1fYX0Ug83uNFfY3ZxarK5LgmbilU54HUgoJuOkUIQBTnLvqzI2BOa1aTrNnqSZyTjlzFigm5si1hN15lm7F5Sc8915w+CZYF/shTgw563ITckCd3NsqhG8+AUZK5sSD5e/qTITQErX53LpCvuiPqpDE8YYpZueaDcjnof0DeE1o0METti1pdXJO37IbJhTigis0dNE2aa3VHaSLaCn1yZkAKFG1Mwuek03L/+eeF6+XnnA7Mil2ERy0coBHWbAS6Fsf8y2+I76x9ws2JX1Ms/KQnvwstKPBukrsxLE+654EvygtQiHiaD8/vrOLoW75t5fVKW586UiIPHJaEtzhqPega7wRAe06S4zkr0ftEhfsX7dYrpji17nILuxHrTYUJOcW5n6GDVO1ZS80jsH0OcLH7ttmEBmbtoTNM/9SNAeX9PyYFTuchGx36FzvUm1fE8FwWD8iCezWanQ3RyGlRLPHUcQ4e3HAE1yeK0LR4h/3GDhXPkEWJUnVgA5yMssis3PfArJjTCpfz5uJ7q+vtn8gWnoiC74r5bO/pznHo8PdwJsb3xcZhppVZMbHLkUQLtQ9Ru97F0eUbrRLt/AoiT2yYnDeUSVRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(64756008)(66446008)(83380400001)(52536014)(2906002)(66946007)(4326008)(8676002)(66476007)(66556008)(7696005)(316002)(55016003)(33656002)(54906003)(508600001)(53546011)(110136005)(6506007)(966005)(71200400001)(76116006)(9686003)(5660300002)(26005)(86362001)(186003)(122000001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8eDgNDU3yYYFhYmpICutWwCvwQSzGNZnEszYvjVkZjl6wtFdj92yqxwapxoR?=
 =?us-ascii?Q?jb9Z0+nhpLZ1usCe+MW6Il5U9HKL1BS3ZOadCGU5MRc/jkOqyubO/AbFXIwY?=
 =?us-ascii?Q?mI0AL0HMHjOyesotog1am7tpLMbmz/v1fn2EK9KdlTmjDxEPNBSUQ/4aDBZ8?=
 =?us-ascii?Q?F9NKsygftxoaLChdx1mW0Ph8bFEdncRWO2duj9PSWEnSu1pnvA9JaFqEbg+8?=
 =?us-ascii?Q?IIhC5ui5kVUBWdOfJsRp1Jkf8DHOuECXfOfKDNhwaP8UPSFt3qjhasJfHHgQ?=
 =?us-ascii?Q?EgqGsu1QGgNgWXzu4gaw2An2zT65TPzgUUWdJ3uRmDVzwY3g+jNhbW+AfCjn?=
 =?us-ascii?Q?iZXKs8BS+Jzvdu1IP/d2CVpslt8O4rsHp10LGtMUK46kYZ5BpnrLLnrXf0JS?=
 =?us-ascii?Q?PLKnuLa+9/Yb/b7uLnRSD2i8tdpaGbcoKjPq2za+Hvb/kjnONyEyqyumqylZ?=
 =?us-ascii?Q?ukMEg7H11Rp1HSmAcBRvFnW1AtSBKkrAiQgdwiTwnahB+kkbtWjSOq/Ph/bF?=
 =?us-ascii?Q?gOiqj5cECUiPi+Grks34sYVOIrRus5s2+3d85uZWO+/uRvfeiwxzMGZUqzJP?=
 =?us-ascii?Q?psdA6PUhOaAkw6aM97Nm7CMJ4rBQHbo9ZEB/jMnvFcZbNKEGw3WedGWF8Ski?=
 =?us-ascii?Q?2k07tP0t17+NFCnF79ZGz2bOXCecGG1YttcOTfqM1I1uoHlUhR1xNpNw2sIs?=
 =?us-ascii?Q?dbfRagXQ39oQ/TiYlCBZ5zHVNbQB16E289b10hWLtn5+lT+5tsYyrBfZKee4?=
 =?us-ascii?Q?687m4yRZ6T0CaxhclwKIAQO4kPK/350DA0j1bWqicrdieeTK/aJen8SRN03b?=
 =?us-ascii?Q?BQ5gunMkPCQsl9Du45XKgV8EyHilY9vU55eQWPfEeqsXXSLx6jsHG/wKJy3K?=
 =?us-ascii?Q?daLaCJeDim+xAn9Ly/E6fv7XfKA+MbggxNfmQnLF9cIH4vbuutSSsMOfTQpp?=
 =?us-ascii?Q?HVcf/fxqauQJPMXodWlzY86qtU/46jFFinVYQ3Ug1I2K3qoogNw3KW0JZXx3?=
 =?us-ascii?Q?DNdAwCrI/hEj4I0JoowFKoNx3iYL15rsVK6JQ/1NKpVsP6bTY38xApBJpGIn?=
 =?us-ascii?Q?d47t4Zui25FAtw7Mn2Kh2HKeNL4cvP+V6YH6UNQAhkn7EdfZSKjmWStc1Ea9?=
 =?us-ascii?Q?cF7yaXMQBG0f6lMqJqiIGu/gEWMDT/nJLNZ4xa3pGfgRmWSKhKyDjiq5+81D?=
 =?us-ascii?Q?WaueO3WpfiqcD9sy+k7W70hYyJsufQWbnblBz4/OJdBhar5gbcMqwvzdCB7E?=
 =?us-ascii?Q?u5/N3NLbWWdHarfJUInwlpIBjKnEgiK2p1TycxBySGSEaMOs97hdcl0/2oXR?=
 =?us-ascii?Q?hxiy0OgNa4kAJDFHE7K+4IBoIFIcQZhp9E4qG4HHt0Zus18zfVAboQrcSS0L?=
 =?us-ascii?Q?cNBsyxrlTegjYC7S5jE/9/6/vBDnjs0Y+uAfIIZoDRt0/ch+FBOhwottlIiM?=
 =?us-ascii?Q?OdRsOW6JMS2CQbfbpg+N7x2BiP3iwb/HU8IJ8DQlbFCcSdEy/DDkn1klPwDx?=
 =?us-ascii?Q?bgcuj+l/lIs8+bjapVLwxPA67dU8y51XxRjVFecodp+iBXBT5MQL+V+9B/DG?=
 =?us-ascii?Q?WNG1zSdng5UNIHN2jbNOGUunCLdiAmGXYnGzJrj41Fj7WZqWoYCIN5vGWd9N?=
 =?us-ascii?Q?HQ/dN2BKOlAB9S8gi5p1z1o5RNX52VThNC4RGtu/AjEZiHI13dZbEU7y48vM?=
 =?us-ascii?Q?q8Bi7JecIkfwhXeTb04O2eeqN0ppb3YDcGXO56WfdbmOw0/kHhrHM5LjSPWP?=
 =?us-ascii?Q?fijmSv0y0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f26ac1-865e-4bd2-5118-08da323be6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 04:16:48.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vekWGGdtoGVJpWJxBjkwdMlOZzOjVit6TJ0rilkHugiQq/tzTtQ9rWVelqaE5t39xYoSdWRauGHFPmZL9JE4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3353
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,
	Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Monday, May 9, 2022 10:25 PM
> To: Tom Rix <trix@redhat.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>; Moritz Fischer
> <mdf@kernel.org>; Nava kishore Manne <navam@xilinx.com>; Wu Hao
> <hao.wu@intel.com>; Michal Simek <michals@xilinx.com>; linux-
> fpga@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
>=20
> On Mon, May 09, 2022 at 05:43:58AM -0700, Tom Rix wrote:
> >
> > On 5/9/22 5:11 AM, Dan Carpenter wrote:
> > > The type needs to be u8.  The type was accidentally changed to char
> > > as a cleanup.  Unfortunately, that meant that the
> > > zynq_fpga_has_sync() function never returns true.  This bug was detec=
ted
> by Smatch and Clang:
> > >
> > > drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync() warn: impossible
> condition '(buf[2] =3D=3D 153) =3D> ((-128)-127 =3D=3D 153)'
> > > drivers/fpga/zynq-fpga.c:246 zynq_fpga_has_sync() warn: impossible
> condition '(buf[3] =3D=3D 170) =3D> ((-128)-127 =3D=3D 170)'
> > >
> > > drivers/fpga/zynq-fpga.c:246:14: warning: result of comparison of
> > > constant 170 with expression of type 'const char' is always false
> > > [-Wtautological-constant-out-of-range-compare]
> > >                         buf[3] =3D=3D 0xaa)
> > >                         ~~~~~~ ^  ~~~~
> > > drivers/fpga/zynq-fpga.c:245:50: warning: result of comparison of
> > > constant 153 with expression of type 'const char' is always false
> > > [-Wtautological-constant-out-of-range-compare]
> > >                     if (buf[0] =3D=3D 0x66 && buf[1] =3D=3D 0x55 && b=
uf[2] =3D=3D 0x99 &&
> > >                                                             ~~~~~~ ^
> > > ~~~~
> > >
> > > Fixes: ada14a023a64 ("fpga: zynq: Fix incorrect variable type")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > The ada14a023a64 ("fpga: zynq: Fix incorrect variable type") patch
> > > went through six of revisions.  The kbuild bug found this bug early
> > > on but the author ingored kbuild-bot and kept resending the buggy
> > > patch anyway.
> > >
> > > After the patch was merged then I sent a separate bug report and Xu
> > > Yilun asked about why only the author was on the CC list for the
> > > first bug reports.  A valid question, definitely.  I will poke the
> > > kbuild devs about this.
> > >
> > > Hm...  Actually looking through the list there have been a bunch of
> > > bug reports about this because both Smatch and Clang complain so
> > > kbuild sends duplicate warnings for this type of bug.  And then
> > > kbuild sends another to say "This issue is still remaining" warning.
> > > And then Xu Yilun sent an email "Kbuild-bot is still complaining.
> > > Please don't forget to fix this."  So that's at least four public
> > > emails about this and one or two private emails directly from kbuild-=
bot
> to the author.
> > >
> > > The kbuild-bot wanted to send *another* warning today, but I decided
> > > to send a fix instead.
> > >
> > > LOL.
> > >
> > >   drivers/fpga/zynq-fpga.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > > index 6beaba9dfe97..426aa34c6a0d 100644
> > > --- a/drivers/fpga/zynq-fpga.c
> > > +++ b/drivers/fpga/zynq-fpga.c
> > > @@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void
> *data)
> > >    * the correct byte order, and be dword aligned. The input is a Xil=
inx .bin
> > >    * file with every 32 bit quantity swapped.
> > >    */
> > > -static bool zynq_fpga_has_sync(const char *buf, size_t count)
> > > +static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
> >
> > This is called from zynq_fpga_ops_write_init, a fpga_manager_ops
> > function that
> >
> > uses 'const char *' as a type for its write() buf's.
> >
> > I think const u8 * would be a better type for all of the fpga_manager
> > instances.
>=20
> I don't think it's necessary to change the write_init(), const char *buf =
is fine.
>=20
> For this case, if the cleanup is necessary, just type casting the buf.
>=20
>   zynq_fpga_has_sync((const u8 *)buf, count)
>=20

zynq_fpga_ops_write_init() and fpga_manager_ops ideally handle the binary f=
iles so I feel 'const u8 *' would be a better option here.

In the Initial version of my patches I have done only type cast. But base o=
n the comments I have changed zynq_fpga_has_sync() API args type.
For more details please refer the below links
https://patchwork.kernel.org/project/linux-fpga/patch/20220308094519.181664=
9-2-nava.manne@xilinx.com/=20
https://patchwork.kernel.org/project/linux-fpga/patch/20220322082202.200732=
1-2-nava.manne@xilinx.com/=20

Regards,
Navakishore.

