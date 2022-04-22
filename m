Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBDD50AE91
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Apr 2022 05:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443750AbiDVDlk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 23:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVDlj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 23:41:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D24B1F4;
        Thu, 21 Apr 2022 20:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+gca6+mwWdu2lCCkWnnH7Hn4P+k+19gHnBeeh2/IKHQn8j+y+3zRnPBot/5TGn20dB0/xXde85PfBaPtxmXiLosnmiA9C4uEFCeuyuJO5gVtXyb/As/n8+H/PodiOgLo5w+F+Gi0/e+U3dY1CXcFm6vdhIz/wVkRrk9PwS0UJn3S+XRwc7crHP53KEyhNRQhUuL2o9ObRkBuZ3mnus5bjGPu+j7TPLbuzRhwp6drNlxELOBBU7916BfZhdcNR/j2+O0ycVS78FBV57BilGTpeU8qrh8NCdodKte6Q8yL7L3r4Q3Mp0QR1ajxOC3DIJ5pcln3U8RtV7bZ5N9GRY3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe/iAw1ZdJBfleYq1osBkCtXkrNDH97ZzR/0F6re2v8=;
 b=ApIayk31r6bm0U+i3JLcU7iPmqHuMlSA4Y9kEikcrBwUhwColNNdfKwi/XhrQCvGEZhlcrzccOUvtst/+GuPHylqExbpjmXcJrNzmWHDoXH+B1fuCleW+99iqhZmOWYJRen9CzA4ezjN4OG1r4xc8EpoCBpBS+6He0xfXK12Y72g8hs4G949FlSxFmsoS6k09LumEuBYUbdA7+Q4Ukpuz+NJt5yyl8SxfmdGs20qBj4bUqxF1H8ZdPlkO8Ux4a35E+dg2ACBMWHILHeVJv4SzjLbTJQ4QZP/6lak8/F2+L/NgpjrPZXZZpJrcqFvzayjkJnDh5tNT8SUa/3qE1Xhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe/iAw1ZdJBfleYq1osBkCtXkrNDH97ZzR/0F6re2v8=;
 b=IgyQwL9bImPD+KCqpj8xegxog1r5EWNSN1F2O1/py8nfOb6MxFQbtIUuIvHdcXk88yjacmdhSTD8TAF1fGe5C6R0O2+/MaZSRat5ZoJjgroo6J+7d5niypacTQl8lGDcEfuAO67fKmagK0ghxcJ5h8SkXYEPjprPgyBQSJHr46k=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BYAPR02MB4517.namprd02.prod.outlook.com (2603:10b6:a03:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 03:38:42 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 03:38:41 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v5 2/5] fpga: fix for coding style issues
Thread-Topic: [PATCH v5 2/5] fpga: fix for coding style issues
Thread-Index: AQHYVTr68HLIPy4mREOhtkhcmTvWhaz6gAiAgADJcmA=
Date:   Fri, 22 Apr 2022 03:38:41 +0000
Message-ID: <SN6PR02MB45768D3AE78598F410CF7AF1C2F79@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
 <20220421044744.3777983-3-nava.manne@xilinx.com>
 <20220421153411.GA347460@yilunxu-OptiPlex-7050>
In-Reply-To: <20220421153411.GA347460@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 648b961d-95fc-4a50-5859-08da2411983a
x-ms-traffictypediagnostic: BYAPR02MB4517:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB451743B52E63B10D99C966B9C2F79@BYAPR02MB4517.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0xFKdSjktLMXj6zkk22MExVKyaN4PbOrhTfTv2Runi5XorLVsBnqkn6yHdOzpWNERpLNw7Q5XrQybJquB5wH7Ss6LERnhguJac5p6OiXuf2VRfxIMMgjwo/0F3gzBazVqMt3FWJH1S1U44LE1JB5HccGHoLUwd5wGdCeX9iES1F+cuYdVY1NRh9Ok/SqbIqTuCGKXlvFs1+URIy99H+T3wqGfi117MRW23c1/+yg0lTDnUzBqAPUHY3q/VQ9MkMUN+UfwbOhI3PPoHETgXwjiH1uPLlyoniVN8qqxyJKhQM63YNxmoGFLYnM4CZVhOoPHSENqFpoJEtxYpXvkeJqd6xmpxqOvoMa7/XouVhBwJGj0OO8/PLxCr4f4wbJJ5ALLi6nnWaGkHf1pRYHLBW7AqgmCJu7E3zyKnU3a+747U8bhbOZo7esPSD969v5Sw7LD6uMZNJDt4UsQLGZmB/6RCZPtm2PwRX3H33jP9IiegMzZMpkgH/V9zFllJWA2z3DiYvgoPTH1ocFQ9wyz7bwO2oyNNzGwnrt9/tGG6/kIXWYenHaw/bxzjxaDO4WjrHrbiDxA0FjLKgjw9nduLEp/3UUYEWz8ifCMUWAj0tpjII0Q/zyY3dQO7KceRUP6TgP9tk0NRhjbgvpPBVITax3kDqdzR5Pzy5KLEzmsRMmXXBHxcdaGlY3qd+M666zm13SuJoTo3IwEcghBrSQ+YxWNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(6506007)(7696005)(86362001)(9686003)(2906002)(66556008)(8676002)(64756008)(53546011)(66946007)(76116006)(66476007)(66446008)(4326008)(316002)(6916009)(52536014)(55016003)(54906003)(186003)(26005)(107886003)(508600001)(38100700002)(5660300002)(71200400001)(38070700005)(83380400001)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eWSixQ4pAYVSZHELFUkKxUpaAzwfN1gs5tk/3MyKySMpGGF3ji6I7quuAyEv?=
 =?us-ascii?Q?QmsqHOQa9/V1cou0kR7F3qSqgwEnDZgdjZcEpfY2m4oQbQp4eIQ+7fMQe7f/?=
 =?us-ascii?Q?r+ywHwdEynuJFMv8v80h0qpZxu7+nPLMJ1yjs9HWt7l9tUCpjM2B2nk6+981?=
 =?us-ascii?Q?hDZBqzBPRfv0BXGqzjRWg550gT7ZTmS62BmLkvc3v6V5JikMm85KnR+KqShk?=
 =?us-ascii?Q?BZrMcYtpOKLBdj1SjPgQDwNuJdNpag4dUe9vv9idWfsjS0BG47PxubJmt4W4?=
 =?us-ascii?Q?1kTtZzBpBRr04hu/CLbA0gqU6lG5RB1PaJn88nRANBEhuY/gTHWAHNIrC0Jh?=
 =?us-ascii?Q?fTxuqreC4uGAK6HrelglPqA4ObMJvkFX/nz/KNP5RdLj4/ujSG1rvRDHgyb9?=
 =?us-ascii?Q?bK+VE4EfZcLLLYwMfuqnN3tIYj48d8Grsv/4jOO3l1WNU1ueONvovI+LrWHA?=
 =?us-ascii?Q?5cvJswLAH4sm+MhjiOc4t5WNU/JcnzjLSWzxLB43FdQkasUOb0eJUdJUys+A?=
 =?us-ascii?Q?AgQqgXIzJKVeAnEusvXiPSyv8fzU8SXnWoC1ZWqKXr3PU5KydN+ECo6yHTPg?=
 =?us-ascii?Q?ESMu2ZeIayYetelhh0cy57XxNxlitlazkmWlRY/g7l/Uvy6YHgg0XUjkeWae?=
 =?us-ascii?Q?9uWUG2yCbhoLY4Z9n0pzXN2i7WtnSqt5Y19iD5Fw9NJ32rokD6++xjnsmilE?=
 =?us-ascii?Q?9jqcS9FnXjzC3Nd3pTUAOFLVpz8PkPoOGqGff82duB8PUmrjU7S7aP6ZVqYx?=
 =?us-ascii?Q?8uvXFQXZI1Jxg7YibFeVJFcgtbcXWmRIAVfVigPkp9LOA/ACVfAasJybaop7?=
 =?us-ascii?Q?S4mAE6qyWycvOjhtzAlM2vvLOd2jdLnPKs34Ab3gDLqE1fU7YsWFWhKyX7/E?=
 =?us-ascii?Q?SElberKDE77zbXChySyyQkuUSrwrA++eRJGr0fv6NBqckSsr/1e6tnjJNU6h?=
 =?us-ascii?Q?fIxoF4dm8jV2uZh6sJ5jHsMV2HTMBUDBTpFmUnACGtinOpfxSX2u7JBlBcAU?=
 =?us-ascii?Q?85y1ihl8+em0/JIqzFeAh0KVqIu9pjNLyPdlHLiiU9YDY+A20IX0dBXRykYk?=
 =?us-ascii?Q?c3vz/0fowQrHk1Y3vatubm6QIxqc/YGNhxALOMpAbP8tSVc0MuhQn8na3JD8?=
 =?us-ascii?Q?E0CqEsEbLy6OOUFKBoOhfGQI/X2NrTp5k+eS7SzicYSRP+5R/GaRWsT53W3G?=
 =?us-ascii?Q?qWnbcLe5HPr9SSwSrRzAUi/gn9okQfXbjVIzR6Z/W/1R8QHVLi/Se+7Ntu9a?=
 =?us-ascii?Q?l60xEhQvKukVgXnXHg1Ecl2Mer3OobtS6o5RB9uiWGEo9lMejanQBiCkuytp?=
 =?us-ascii?Q?OYfaGZQWuDEpD5xnN1vOdb1HCHmevF9jWPruOYZjjaAhSqevOLKpwuUhm6Ls?=
 =?us-ascii?Q?SHFf09oQplY41+yuT8qM7hdtu+gWI0501ltA4XQTIQXzVl2ri3r9CxUCBB2C?=
 =?us-ascii?Q?p5LgOydm6N/AxPzE4IgkjsQDFiKP7zVz+umoPd41yQ4uSpR/83DBM8OJjAaU?=
 =?us-ascii?Q?eCnb1Qh80kb7uaGPziwJZZ0S6zvq5aA9hBgmXyKCtXp+DUar1EtYO0WsVMIJ?=
 =?us-ascii?Q?IeOZHnn1vD+bt6/579JKCJ8sTW0l5V/gxE9OXR+5Oc+iBbLO7mzgDAYBVj8A?=
 =?us-ascii?Q?8YTGuMO2uAgg7mHjEomyIJ4k1f4TGfDBMebYUo9YJVXPSQi5wSnQ/M0XyRo7?=
 =?us-ascii?Q?mhyRmQOXb3w/tXhIGzUAf2dX+F+JmjSVYYKikKldSQiTSVSt4OXm31kMLQsq?=
 =?us-ascii?Q?yaZpGJ1ANQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648b961d-95fc-4a50-5859-08da2411983a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 03:38:41.2726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kqlm2TT65sMvSOzfs/4zqZEH3JTThL8yffJJXHDmWAB9YBHyYImlq9l4ej30wI5fDbMHgu+xkAz4QNByde55gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4517
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Thursday, April 21, 2022 9:04 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v5 2/5] fpga: fix for coding style issues
>=20
> On Thu, Apr 21, 2022 at 10:17:41AM +0530, Nava kishore Manne wrote:
> > fixes the below checks reported by checkpatch.pl:
> > - Lines should not end with a '('
> > - Alignment should match open parenthesis
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20
> Sorry, the checkpatch maintainer Joe gives comments after my Acked-by, so
> maybe more changes should be made, see my comments inline.
>=20
> And if you have more changes than expectation, it is better to remove the
> Acked-by/Reviewed-by tags, otherwise people thought the reviewers are
> good to new changes which are actually not checked at all.
>=20
Agree, Will remove in the next version.
> > ---
> > Changes for v2:
> >                 -None.
> > Changes for v3:
> >                -Fixed similar issue exists in "drivers/fpga/*".
> > Changes for v4:
> >                -None.
> > Changes for v5:
> >               - Reduced the length of the 'fpga_mgr_write_init(...)' AP=
I
> >                 as suggested by Joe.
> >               - To align Include declaration and definition of APIs upd=
ated
> >                 the FPGA-region.h file as suggested by joe.
>=20
> The of_fpga_region_parse_ov() changes are also new to us.
>=20
Will fix in the next version.
> >
> >  drivers/fpga/fpga-mgr.c          | 4 ++--
> >  drivers/fpga/fpga-region.c       | 7 ++++---
> >  drivers/fpga/of-fpga-region.c    | 6 +++---
> >  include/linux/fpga/fpga-region.h | 7 ++++---
> >  4 files changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c index
> > d49a9ce34568..d9a2aad7b35f 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -148,11 +148,11 @@ static int fpga_mgr_write_init_buf(struct
> fpga_manager *mgr,
> >  	int ret;
> >
> >  	mgr->state =3D FPGA_MGR_STATE_WRITE_INIT;
> > +	count =3D min(mgr->mops->initial_header_size, count);
>=20
> Move the line in 'else' block, cause the count is not used if(!mgr->mops-
> >initial_header_size).
>=20
Will fix in the next version.
> >  	if (!mgr->mops->initial_header_size)
> >  		ret =3D fpga_mgr_write_init(mgr, info, NULL, 0);
> >  	else
> > -		ret =3D fpga_mgr_write_init(
> > -		    mgr, info, buf, min(mgr->mops->initial_header_size,
> count));
> > +		ret =3D fpga_mgr_write_init(mgr, info, buf, count);
> >
> >  	if (ret) {
> >  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> diff
> > --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c index
> > b0ac18de4885..3864bf4f8920 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -18,9 +18,10 @@
> >  static DEFINE_IDA(fpga_region_ida);
> >  static struct class *fpga_region_class;
> >
> > -struct fpga_region *fpga_region_class_find(
> > -	struct device *start, const void *data,
> > -	int (*match)(struct device *, const void *))
> > +struct fpga_region *fpga_region_class_find(struct device *start,
> > +					   const void *data,
> > +					   int (*match)(struct device *,
> > +							const void *))
>=20
> According to Joe's suggestion, it had better be:
>=20
> struct fpga_region *
> fpga_region_class_find(struct device *start, const void *data,
> 		       int (*match)(struct device *, const void *))
>=20
>=20
Will fix in the next version.

> >  {
> >  	struct device *dev;
> >
> > diff --git a/drivers/fpga/of-fpga-region.c
> > b/drivers/fpga/of-fpga-region.c index 50b83057c048..55209737075f
> > 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -189,9 +189,9 @@ static int child_regions_with_firmware(struct
> device_node *overlay)
> >   *   fpga_image_info struct if there is an image to program.
> >   *   error code for invalid overlay.
> >   */
> > -static struct fpga_image_info *of_fpga_region_parse_ov(
> > -						struct fpga_region *region,
> > -						struct device_node *overlay)
> > +static struct fpga_image_info
> > +*of_fpga_region_parse_ov(struct fpga_region *region,
> > +			 struct device_node *overlay)
>=20
> Don't put the '*' at the beginning, it should be:
>=20
Will fix in the next version.

> static struct fpga_image_info *
> of_fpga_region_parse_ov(struct fpga_region *region,
> 			struct device_node *overlay)
>=20
> >  {
> >  	struct device *dev =3D &region->dev;
> >  	struct fpga_image_info *info;
> > diff --git a/include/linux/fpga/fpga-region.h
> > b/include/linux/fpga/fpga-region.h
> > index 3b87f232425c..7ebf743b8f8a 100644
> > --- a/include/linux/fpga/fpga-region.h
> > +++ b/include/linux/fpga/fpga-region.h
> > @@ -52,9 +52,10 @@ struct fpga_region {
> >
> >  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> >
> > -struct fpga_region *fpga_region_class_find(
> > -	struct device *start, const void *data,
> > -	int (*match)(struct device *, const void *));
> > +struct fpga_region *fpga_region_class_find(struct device *start,
> > +					   const void *data,
> > +					   int (*match)(struct device *,
> > +							const void *));
>=20
> Please also follow Joe's suggestion:
>=20
> struct fpga_region *
> fpga_region_class_find(struct device *start, const void *data,
> 		       int (*match)(struct device *, const void *));
>=20
>
Will fix in the next version.

Regards,
Navakishore.
