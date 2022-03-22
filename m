Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A964E393E
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 07:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiCVG5Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiCVG5P (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 02:57:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A3DE54;
        Mon, 21 Mar 2022 23:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kadU5SF9OnoH/A7WRZ1BKMIhesL1kEruo1/tlXhvjSOJvfr09WmSETb45RaERafObk2Q/WZyRtms/296GcN8qJG/OCemi8/7pcv8XKxoee8xIqLUnnbeLoZWAOKeg2V4X4bge4iGzxBzZKUX4wVrYwbOACC26P90R23XTSUY4VaujXYw1V8eZB0+NM5NXlydpNQLW6ZuHpOXZs7ZdjEfPSpSwpfwY2/agQCUlXVXZZ2kOQEwVDsAZ1hv2IzkzzQuFHo7oGWId/EdFMi8hsJqnQv2wdr5TRC//m/D2ybIJrsil6UcFNiV7nn9HkgGanigSB0v18v+MZZTm8Dq6cWQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuI6yIdxLXTw/7bHl6I5izzXym1faE0XLsP1k+NVMRs=;
 b=KW6z12R3yLPMLKCIzk3KE+AqbpXSKTCkeL1ZrPYlMVTjPEBK7vxjwZSKKlVYVk8C1bHc3rJoZJOG3qacaV/jM+KmKZPEl+2H8PjFfwLcDZDOQtXS4eNYl1BKHglfqpwYxqsr54KONzu32401CWfQznG4icG8qnc90IYWs6n0p6BxyBPypPdM9gT4yMrpnqPUxDcBU67t2nd1cSxJ8diHVPTjt7aF/B42z8qT3A3jXaUvCtPUAzDzRr926nyAZdSNc7P57HAinEzkdvifyhISDjSxNq85XaZnKU7pmpFK8O0qnanEIG3CEljQam0EMgngrpJwPpyhrqAImQt16kkTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuI6yIdxLXTw/7bHl6I5izzXym1faE0XLsP1k+NVMRs=;
 b=eIRN3dCEYD1IeuVJRx7Or4xTuCJi5GRnoaj4We+T4w0NunAg3hncXBZ3LIFOkaddX/7fh6EXzqQvEQJmEAK0XVvwNedJnIp5aOhlDZCWWa3TN3Ww9sWkubR7RPfx0uGzljeKfTgiXxd49FP740Q+PzjkiW8LLuDe1TpQc2S3sNw=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BL0PR02MB3650.namprd02.prod.outlook.com (2603:10b6:207:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Tue, 22 Mar
 2022 06:55:46 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::6162:c36f:2c80:b4dd%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 06:55:44 +0000
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
Thread-Index: AQHYMtFNadCZe0VWu0OEcc9wpwDlOKy6QtkAgAYbAYCAAEp0gIAKZPXw
Date:   Tue, 22 Mar 2022 06:55:44 +0000
Message-ID: <SN6PR02MB45765A42BF873BDC02DF210EC2179@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
 <20220308094519.1816649-3-nava.manne@xilinx.com>
 <20220311142814.GA97487@yilunxu-OptiPlex-7050>
 <SN6PR02MB4576FB4490F96E593E09D4B9C2109@SN6PR02MB4576.namprd02.prod.outlook.com>
 <20220315160855.GA121107@yilunxu-OptiPlex-7050>
In-Reply-To: <20220315160855.GA121107@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e041eb50-ae4b-497d-2e64-08da0bd0fc94
x-ms-traffictypediagnostic: BL0PR02MB3650:EE_
x-microsoft-antispam-prvs: <BL0PR02MB36502EE52637255D1B16304EC2179@BL0PR02MB3650.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tv6sXLJCDnSPfeDFLpUWBcNws4DYeXyjB7sEH0z2uUib1zHPCDQGD6N1dFNADy5qaqAB2Z3wcLCodnD8icB1RaLTCDzTkvwiFejs5w335n0pw7zbdvlUd6qYZ8eYAicINWMUNdMhZV/mWf87DBGH+Bim6xmd+4tdVnlrpH8zPtOi5ESOtz6E3bM0DOB4VFHN/ldvgHbihRzTCOyM71sy+qeQaKp7VIIp225AoTN/v6eHyEsNkFv/Z1q9QKebcw1e6CQCPrqJt0rAxpkZvaf1HBts2/vBDdKk8n2fx7KPbjus6WuScHwFZWZfk0edbDbgmCMEtv7qVfTGarD1VWg46QnwVTpceZed/XMh3WoZGanvSwYmf98UcMegDLMx3eeeGQv4ZGfl6/kK23bIfRJKzBPOma6ntRWmkm+cTqnERVSf6X6WzzI8doKk6kUwu75+LWUYMFMiqodvhnvXP5AuQ9K92wLKlNPZtrOutcOHyxmMEUIHNKSBHfMXA1zLxY66ZoLl1VzeSDwtDrDHysXVf6tkJupm0wRdYBx+AB/jKp2c1gaLVQVOFyA8byIvbgwmgjTh9ddX2eWReAARU+UNzmP4KTRTeON0hWqrQYAS3c9mEmISCjO/0FKhHxiw1hH8XCSC1eE45IrwSOV95Ad5Tw03hvgBXvhk7hjs+mjPFNsd1VMYBaMPNcQrML42GozL1/ACIs1ceyrpQuIDdnBxZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(6506007)(52536014)(9686003)(33656002)(7696005)(53546011)(83380400001)(26005)(186003)(71200400001)(55016003)(508600001)(38100700002)(122000001)(38070700005)(86362001)(66446008)(54906003)(64756008)(2906002)(316002)(6916009)(66476007)(8676002)(66556008)(66946007)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2V12AUjXCbjUrEuiDgkdIWvA9PRX1vS6jcg/7/c+cIVoOj8rL4gl8Fra84H9?=
 =?us-ascii?Q?+MwpPUo1TP5JR3WgxB8Af1eHUgmKg3R4YT3CeMNnJQN/oSA+FhIg2R9EdbZS?=
 =?us-ascii?Q?r8eEuvc/4Vo1utfWld+vxfQUcOYIz/BcAPQIylJcX+XG036174TDw2+ycSVh?=
 =?us-ascii?Q?DosSFN7a+SFFUNrxOJCS4+c2Yj27MZt29+n+wLs2bICL4O/nY7YSAli8QNhr?=
 =?us-ascii?Q?VxnTZAq7vbK2BxlOyZfy+Dt532LT9RaQqBHqOJL6D+zlZvfFJf9gD1jzh/sl?=
 =?us-ascii?Q?hUllsPII0VM0uBtDH6ExjxFxkoWRgFnufvl8YkMatiyK0rdoxxxDiv89P3/D?=
 =?us-ascii?Q?5qxvVQK03OmD08r51fFpzx/77cLWfvlD+wKWPeNUhm0NI24ksEX7KL98YJpl?=
 =?us-ascii?Q?yOzIFmxtq5sy2e1n7dzC3lL6Am/KZY+0YTw3oWeIA7Fxd+52Az0ZSTFovVDE?=
 =?us-ascii?Q?UyW+VUQmeQPkwy7Wxhl2trOxtWdkublfNXX8CYki70JnDGwapBAjhZh6or0+?=
 =?us-ascii?Q?Zygs11Ul0wjcBC63J1SvkmEbvfD6KSyP9X2DPFKs3JpwJqjelPi3OKv/XJKD?=
 =?us-ascii?Q?U/MbFu/E7Qya96DO17k7vdjL2/4qEM8pWGKxX8W1fgJBbJKDUCIe3o/U4hAs?=
 =?us-ascii?Q?tR1QGeZ2o1FcX8SrwkdN+2NteR5yNumS5pL76BkieHpu4svMTebtQKW8nuE/?=
 =?us-ascii?Q?a3zv4Guexapev5JuIzGujjBq6vziwW2SrEy9F8wo7LFJv8MGAnaNajXNJmbx?=
 =?us-ascii?Q?HyqPZ1GEUauUgPQXZFB2ZrGfFZ0neM1Zp7RCNPss0cW0Jizw7snjqDQQnRx4?=
 =?us-ascii?Q?VGL7+TwoXbrN2fW0ScoyuLqW+WZMqUXcHVs8Ja+xOVgdji4l5bmaz6CqKyYo?=
 =?us-ascii?Q?HcMQMGV9VjIVyRiqrbZ7d/hUCKny3q1KUWqcZYskgUEwQFkqu9ZNpB+fNzOu?=
 =?us-ascii?Q?8EgdqRCazdNrNfzNWkihNgrIcXAvaf6w/lLZn2nV8GGZ031kPgSQ35gyL8qi?=
 =?us-ascii?Q?/x8iWp2GoGXmjMMhYQRNNNbiXn7uicc8N3rpiwlbJBRMx4kT0BiJulJl+vtC?=
 =?us-ascii?Q?KMXmFteNtW1xyX3iB8aYeX8coA43K5WhUetJD6DoDSLE91xjFUbQeed7mFBl?=
 =?us-ascii?Q?pFOFD18o1Vg9BF/fPRpvkARbFyvS8c8t0UITFUgM1zKgyhjWdMT3LJGpR8Fv?=
 =?us-ascii?Q?Z3jbQb5izfkrPpTnNTAqUCxmOCPR5t4dwkvGMSyWsSGt7BhF+SzlXto9CGtL?=
 =?us-ascii?Q?5iATZKxMX1GwTvzjPM1jwDfL6jgnNMvL9sj9bu4iDzZie9Vga8CiibadXf2d?=
 =?us-ascii?Q?q+5RkkTwq/y/I6lmOl/td8pxUnObSIdYfqZbMdMSyJoYLkKbC2WU/dSFVYIi?=
 =?us-ascii?Q?xsoDt4Ojo796xR3EjWgD5RU2Li+ND8A6HwYtdSYZELhSWXvy5hSHHKNJrwq5?=
 =?us-ascii?Q?DfEQqhlMdXYKN+omn4ci1FLoUxY7HKZa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e041eb50-ae4b-497d-2e64-08da0bd0fc94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 06:55:44.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6M8z4ALG0Fzz9qGT/m6R7qI3pu84imsYjJEGxbKQtwXXcPTwO3OcUtv8FmByBDUgr1fQgha88GJW+cJiizw8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3650
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

	Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Tuesday, March 15, 2022 9:39 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/6] fpga: zynqmp: Initialized variables before using=
 it
>=20
> On Tue, Mar 15, 2022 at 11:48:11AM +0000, Nava kishore Manne wrote:
> > Hi Yilun,
> >
> > 	Thanks for providing the review comments.
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@intel.com>
> > > Sent: Friday, March 11, 2022 7:58 PM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> > > <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH 2/6] fpga: zynqmp: Initialized variables before
> > > using it
> > >
> > > On Tue, Mar 08, 2022 at 03:15:15PM +0530, Nava kishore Manne wrote:
> > > > This patch initialized variables with the proper value.
> > > > Addresses-Coverity: "uninit_use: Using uninitialized value"
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > ---
> > > >  drivers/fpga/zynqmp-fpga.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/fpga/zynqmp-fpga.c
> > > > b/drivers/fpga/zynqmp-fpga.c index c60f20949c47..e931d69819a7
> > > > 100644
> > > > --- a/drivers/fpga/zynqmp-fpga.c
> > > > +++ b/drivers/fpga/zynqmp-fpga.c
> > > > @@ -41,7 +41,7 @@ static int zynqmp_fpga_ops_write(struct
> > > fpga_manager *mgr,
> > > >  				 const char *buf, size_t size)  {
> > > >  	struct zynqmp_fpga_priv *priv;
> > > > -	dma_addr_t dma_addr;
> > > > +	dma_addr_t dma_addr =3D 0;
> > >
> > > The first use of this variable is as an output parameter:
> > >
> > > 	kbuf =3D dma_alloc_coherent(priv->dev, size, &dma_addr,
> GFP_KERNEL);
> > >
> > > So I don't think it needs to be initialized as 0.
> > >
> >
> > This issue is found by Coverity Scan, Whether this param is input/outpu=
t
> this fix will not impact the actual functionality.
> > In order to fix the issues reported by the Coverity tool, this fix is n=
eeded.
>=20
> I didn't see issues about this piece of code, so I don't think we need th=
e fix
> just to make the tool happy. Maybe the tool could be improved to help us
> better.
>=20

Agreed, I will drop this patch in v2.

Regards,
Navakishore.
