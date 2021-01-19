Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE042FB195
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jan 2021 07:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbhASGgN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jan 2021 01:36:13 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:12961
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729355AbhASGft (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Jan 2021 01:35:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byHwvtpH2uGU2TtTG6b2+lKZaa4WUDRBWw5tHJusxJxWAc87d00DuSR2sxPwblRqGr2zLeeQmdcS+HeDmUZDMw7KaYjkZ5KNkDAdJDqSkkfqdzeJWlULvdtRIHyLMdBbLFgnrq2kj+nXKudp2Nlac83Eb+eQPIagOlQd6s+Rf3Gbk4TuSdaKbPOzfj7DkWw5mQMByyCjssEfz161JVchr/HSHw3x9ueFDeqWeEUw1v8B2eGb28JbVz9Miz3LPtnbAtuUz4qJkjc1+rBvoYBEb6FaBTSrY6k/4z0rdlwkp8qysIvF25jNpxIv/1jzSXTTdr7MkregE7eDWXy8DC/DGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrhZUodiJfMFAxSbRNYkrWxw/AKd1msgBwqT3/r0bPI=;
 b=UmrcqW5y6n5FY1m+1WEx6ldVVEr4ooFhz+Z74qcS8krWzmKtKuR57Up2G53rfxiwD/5U7ysc5rXcUzgCNBK/x+RTQQxJQasrULVzoQyOIcdFryJh6fTO7x1l3s4huaH7ypT65j1aq9usbX6K/8f2RY/GGesaiQg/KeKECmzjZAPo1pvgD1F9Y0cVz+50QnaXBLRulgR9R4HUzCrpPMBjPr7u+6UZ1W/w8OGd6mBPY57oFO+7NxELY0oZVP6Ee2I4kcnczrxY9Hhb5BQeTo210WRJVGRZye3q+REnd8mnaL24WMNybevfS2JQllNhNtYxn1Hm6GO7EUejL+l5ldYNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrhZUodiJfMFAxSbRNYkrWxw/AKd1msgBwqT3/r0bPI=;
 b=CmpzahTySXDe4qxUtfz3msnYIyFEp3STNQQcDijg1Cc/mg+VjUoWCn6j/SJ2NGX5fMDY3gP3k4wKcxufTxxMVIK25c0Za0o1L5SBxUUnKiEZkR6Ems5me5iVIHd3krh7gO8oE/OZJtGEwtvIzsCR/CfFC65uOvQpngEjNVL+x7M=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB3231.namprd02.prod.outlook.com (2603:10b6:301:6c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 06:34:54 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:34:54 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
Thread-Topic: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown
 manager
Thread-Index: AQHW6t9xKUyYsQdkFk2NaePj2u7pYKopkSiAgATukeA=
Date:   Tue, 19 Jan 2021 06:34:54 +0000
Message-ID: <MWHPR02MB262353F2D236B6AD787FD5EFC2A30@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210115013431.27667-1-nava.manne@xilinx.com>
 <20210115013431.27667-2-nava.manne@xilinx.com> <YAJWT4IDPmHneam1@epycbox.lan>
In-Reply-To: <YAJWT4IDPmHneam1@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07fb4028-85ac-4009-a319-08d8bc445519
x-ms-traffictypediagnostic: MWHPR02MB3231:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB32317FE9E61E7B717C04F537C2A30@MWHPR02MB3231.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nbT2E0HgLyOUyU+NxzP51UEF/KNfNz/7M20Pow2KlMC15J5S6ttbv6eK1SFYObD3gTEdBgiIauu1CJUGeVtRMP+91mXzZgCYRdyIeWsluOVOIWJIT3dYBVxpsXv5kJn6au33H2qIruS4/+T7l7dpmrh67JUao7Hs4PkJZFXlQrMKUoKO3crJcOn8syzVJv11Y8C7ZLkvZSLtVe6dZ5KikgquRZokrHeNUw/radPT1hDl7buqMre12V/FnsNshRcP9JXeXNCO9+QLSZUHlvIFw+rpQ5s3/Max1F1VKvuE4IeTc8wB5+IaUNl2rd7S+vGv7e045DZ45X4P6dgVNwxktEYwiZnL92cf7ICM5J3jnYKC878MdABqS07SKkEUiXkB1ivbpkwBwJlp62DqpZy46Xddsu4uqJ8mbp+RomQIVqopHlUG13PPjbb5uZ1yNMHvAizLP0EDO9diCm7UeawMWYWNNwA5qQMhF+phjo7VY2KSE890UmtN20xyGhfj5cLeuzOr3ZEnUqMhmBe8KacmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(71200400001)(66946007)(5660300002)(55016002)(2906002)(8936002)(4326008)(9686003)(316002)(76116006)(6506007)(26005)(54906003)(53546011)(8676002)(186003)(478600001)(33656002)(66476007)(52536014)(66446008)(66556008)(86362001)(6916009)(7696005)(83380400001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Nfihz5/iE3Ybnm8S1tLiE54wj/XmOGQor+bEE6r+boHuDZu9ACwUfcEm8DO1?=
 =?us-ascii?Q?ecb7ZBK7eXimJGT0RqflNFOEAFD+M/Z28Ui7Qjp8QnwsckrrPUo0XB0khFtQ?=
 =?us-ascii?Q?YlFxU4xBC66WH2qPu3CibYCiEqkR1v2KiqU3qAulH3l2fqOqdTDkNCoOKCJ7?=
 =?us-ascii?Q?IjlqgP1+9ao8K2tpqE+2bzeb55xQWUdzMja0I7ikzwSo38LfOMO/IHn8jPOO?=
 =?us-ascii?Q?pE3n/oBwQXr3YxO5nIaGFy5IOTwphhS2bVOxctBOhGfdYOaLDhWRSMUj4lAj?=
 =?us-ascii?Q?PjDkn3R/8CcF3DMR8roqo4DzXyO9Zu5GvHQ8FxKO1EAXyL088aEdQSFrW197?=
 =?us-ascii?Q?Ww04JP5XIhldiDlDNlJTUHQX4Z42PY5/ylXtQrDjBpd7nYOEqAIvX/zreryQ?=
 =?us-ascii?Q?B2JGwr85n4tiqa8xvsg241+gVVldMj1JunTO8F/3+hp8SgCEVqln9ufjsUo/?=
 =?us-ascii?Q?XsbPO55BWh+V+ctKF29QEnXui2okYQyqk/avqIBa1hwbCDeNuWnQbDMDRtX6?=
 =?us-ascii?Q?oorH4jYVL/jpHLSKwcFkc3+DAGxdiEt94NYrGCUkup0GZmKsnSk7raOrKT8n?=
 =?us-ascii?Q?dMdi2SS/G8shDd9l3n3zA/vFf0vPhayOCGmhubQDd1EAD5ZlszEyYF/zCxAu?=
 =?us-ascii?Q?hZXUOE9Yk8+DWaCks+BcCZIj09Sd1ferdXBNx8XLGmdBmfn4UhpcvYfqFhHf?=
 =?us-ascii?Q?dwT3/en2QuLWW/IQbmJgjRI5/dVNJfdXOgWKNLG2aDkYh3h+e/AfYdqYZaNM?=
 =?us-ascii?Q?gsrVcRtDG33oNvkVbGkzmlkqsnHccvRNe3znMrm40UUb3SMgi5mYfWJgwZba?=
 =?us-ascii?Q?OND4dnrxGG9+N4kI82n1R6jCCOcmXZs5XCvJuav/P358f1fgCMNfSoE5To8v?=
 =?us-ascii?Q?MW/ZwpOotcdKeB+Dc3M6dYosQ1qihUlHY5s3PGBxFWxOXO4tevmFDqr1QpuP?=
 =?us-ascii?Q?n4qF3axw+lLGTFZ3mGL+dU0nDo9k5eRX10qTm2P5W5biD4oGRgkWkB4ov2D9?=
 =?us-ascii?Q?47+lGwhf5q5V6woBdmNIB7UCy6+bCca//HiBe/lOMxoeU6TiuoFwj1WNzJt4?=
 =?us-ascii?Q?+7sZll08?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fb4028-85ac-4009-a319-08d8bc445519
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 06:34:54.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nVMgpf5rSP8IiUPZcJS90zCwwrSgJddcPgoYUuYHAS6ddhVFaE1NSL7ZP9g7LfH07FzquSUvCImaUZho2K0RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3231
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Thanks for the review.
Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Saturday, January 16, 2021 8:28 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown
> manager
>=20
> Hi,
>=20
> On Fri, Jan 15, 2021 at 07:04:31AM +0530, Nava kishore Manne wrote:
> > This patch adds support for Xilinx Dynamic Function eXchange(DFX) AXI
> > shutdown manager IP. It can be used to safely handling the AXI traffic
> > on a Reconfigurable Partition when it is undergoing dynamic
> > reconfiguration and there by preventing system deadlock that may occur
> > if AXI transactions are interrupted during reconfiguration.
> >
> > PR-Decoupler and AXI shutdown manager are completely different IPs.
> > But both the IP registers are compatible and also both belong to the
> > same sub-system (fpga-bridge).So using same driver for both IP's.
>=20
> I'm a bit confused, the whole goal here is to give the thing a different =
name?


Both the PR Decoupler and AXI Shutdown IP manager IP's are follows same reg=
ister spec.
Most of the code is common so we thought of reusing  same driver for AXI sh=
utdown manager as well.

> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/xilinx-pr-decoupler.c | 35
> > ++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/fpga/xilinx-pr-decoupler.c
> > b/drivers/fpga/xilinx-pr-decoupler.c
> > index 7d69af230567..c95f3d065ccb 100644
> > --- a/drivers/fpga/xilinx-pr-decoupler.c
> > +++ b/drivers/fpga/xilinx-pr-decoupler.c
> > @@ -19,10 +19,15 @@
> >  #define CTRL_OFFSET		0
> >
> >  struct xlnx_pr_decoupler_data {
> > +	const struct xlnx_config_data *ipconfig;
> >  	void __iomem *io_base;
> >  	struct clk *clk;
> >  };
> >
> > +struct xlnx_config_data {
> > +	char *name;
> > +};
> > +
> >  static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_da=
ta
> *d,
> >  					   u32 offset, u32 val)
> >  {
> > @@ -76,15 +81,28 @@ static const struct fpga_bridge_ops
> xlnx_pr_decoupler_br_ops =3D {
> >  	.enable_show =3D xlnx_pr_decoupler_enable_show,  };
> >
> > +static const struct xlnx_config_data decoupler_config =3D {
> > +	.name =3D "Xilinx PR Decoupler",
> > +};
> > +
> > +static const struct xlnx_config_data shutdown_config =3D {
> > +	.name =3D "Xilinx DFX AXI shutdown mgr", };
>=20
> If it's just the strings, why not store them as is?

In order to differentiate the IP's at probe time we are using this name fil=
ed.

> > +
> >  static const struct of_device_id xlnx_pr_decoupler_of_match[] =3D {
> > -	{ .compatible =3D "xlnx,pr-decoupler-1.00", },
> > -	{ .compatible =3D "xlnx,pr-decoupler", },
> > +	{ .compatible =3D "xlnx,pr-decoupler-1.00", .data =3D &decoupler_conf=
ig
> },
> > +	{ .compatible =3D "xlnx,pr-decoupler", .data =3D &decoupler_config },
> > +	{ .compatible =3D "xlnx,dfx-axi-shutdown-manager-1.00",
> > +					.data =3D &shutdown_config },
> > +	{ .compatible =3D "xlnx,dfx-axi-shutdown-manager",
> > +					.data =3D &shutdown_config },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
> >
> >  static int xlnx_pr_decoupler_probe(struct platform_device *pdev)  {
> > +	struct device_node *np =3D pdev->dev.of_node;
> >  	struct xlnx_pr_decoupler_data *priv;
> >  	struct fpga_bridge *br;
> >  	int err;
> > @@ -94,6 +112,14 @@ static int xlnx_pr_decoupler_probe(struct
> platform_device *pdev)
> >  	if (!priv)
> >  		return -ENOMEM;
> >
> > +	if (np) {
> > +		const struct of_device_id *match;
> > +
> > +		match =3D of_match_node(xlnx_pr_decoupler_of_match, np);
> > +		if (match && match->data)
> > +			priv->ipconfig =3D match->data;
> > +	}
> > +
> >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	priv->io_base =3D devm_ioremap_resource(&pdev->dev, res);
> >  	if (IS_ERR(priv->io_base))
> > @@ -114,7 +140,7 @@ static int xlnx_pr_decoupler_probe(struct
> > platform_device *pdev)
> >
> >  	clk_disable(priv->clk);
> >
> > -	br =3D devm_fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
> > +	br =3D devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
> >  				     &xlnx_pr_decoupler_br_ops, priv);
> >  	if (!br) {
> >  		err =3D -ENOMEM;
> > @@ -125,7 +151,8 @@ static int xlnx_pr_decoupler_probe(struct
> > platform_device *pdev)
> >
> >  	err =3D fpga_bridge_register(br);
> >  	if (err) {
> > -		dev_err(&pdev->dev, "unable to register Xilinx PR
> Decoupler");
> > +		dev_err(&pdev->dev, "unable to register %s",
> > +			priv->ipconfig->name);
> >  		goto err_clk;
> >  	}
> >
> > --
> > 2.18.0
> >
>=20

Regards,
Navakishore.
