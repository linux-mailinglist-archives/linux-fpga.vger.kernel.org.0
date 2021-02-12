Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3313199E1
	for <lists+linux-fpga@lfdr.de>; Fri, 12 Feb 2021 07:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhBLGO3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 12 Feb 2021 01:14:29 -0500
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:7073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229691AbhBLGO1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 12 Feb 2021 01:14:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAyhZLsiGJG6z2eXJRILyjeXzsymwvv5fxfrwjXwvloFh/U0Hc7TCJY6QQuIW2ZC5G1jVE3HQ66/URNpGmSRJnxrk+dOOMk7tTAxdMvkx5VGTJSlkpWbJehWWnhkn2e7EJ3hZT+TfP8QSYCnU4TZ2MZt+3MBEFibfdmyNVKQMpzyRLMxaAZOCFiVVnwlvU2lFQHGc6PO112HnDgTh1dG/cNXogOISlVd+Pa+ZdQdtxdvpiU/JPPCuKKVS/BSHx+PQT27XUXYYc94yuZZFff6M+fLBhepKmTNaMGMTYQJ/nKacZGfUpBK2Q7799ZVSgY0s9qVgfL9ugiFQ8kpeqc8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO5mhGW2DxfMouFb6K8zEZFLpaTcHdS64772SifrLvw=;
 b=MxEy/rsBlHp6AULVKa8TWgAqJ3Xe3l5Uw17+1JkUgEnFR49r/PWabtw/IvjeI7ZMrj0IBK2/hK/umcwnd+BgxtODfuon24O5Ml+QG2CgJxkw+dmnc9ZwGUamKQSuk26/PUdrlXSX7F1o0Rrd6P48ESYNVJPustgmuSTdQEt8l8XFfUDwxAzgyOei49K4anmmyZWn9oaJdZQNLOH2aWTGYB5wdsgJb+Hy+VCFOHJ1EAGDOtEqnJ7CAmMbV2Rj+6PaozZZlegnf/HVyrOOk42WyC2Cwq16lY9FnpekxWhTSK1nTRIt9Uy577NzAz8cI0S3Zcsxp/1Ya5OlZJ66oX97rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO5mhGW2DxfMouFb6K8zEZFLpaTcHdS64772SifrLvw=;
 b=bsFGZd68WfnyQeaQl9KCLiMMyWl8YJrXJ20suT9ZzUwT31W6oMTiZlsHXsiFPMsIve+FDo4xVyxsvaxJQu8IZF7W6Y7A5rFZuWWdpoEIWqgiS5HiNEabZcF8GDTL8eDcB8LlZEt88iWrbF4pJRMHEtn7qgp8etFTO7ZyhDZ7FhY=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by CO6PR02MB7602.namprd02.prod.outlook.com (2603:10b6:303:b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 06:13:33 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::804d:5b7:ada6:2f4]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::804d:5b7:ada6:2f4%2]) with mapi id 15.20.3846.036; Fri, 12 Feb 2021
 06:13:33 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH v2 2/3] dt-bindings: fpga: Add binding doc for versal fpga
 manager
Thread-Topic: [PATCH v2 2/3] dt-bindings: fpga: Add binding doc for versal
 fpga manager
Thread-Index: AQHXADzdawePkZwClU6ZKWYEIAeZ9apTC6MAgAD5mzA=
Date:   Fri, 12 Feb 2021 06:13:33 +0000
Message-ID: <MWHPR02MB2623787A36B389BCF337D8EBC28B9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210211060532.23662-1-nava.manne@xilinx.com>
 <20210211060532.23662-3-nava.manne@xilinx.com>
 <1613055380.699799.519684.nullmailer@robh.at.kernel.org>
In-Reply-To: <1613055380.699799.519684.nullmailer@robh.at.kernel.org>
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
x-ms-office365-filtering-correlation-id: a90d091c-491a-4ac7-5acf-08d8cf1d5377
x-ms-traffictypediagnostic: CO6PR02MB7602:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR02MB76026FB6816A6470D2E922DDC28B9@CO6PR02MB7602.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELS2g8T2FoWMPHgj9FhhKoCeII/EXl7lMVOvRwWuG5RIHJwaqJswb1ISGTeyzcjNpf1K+MvEeLBClP9n27gHy6dXsA6ehen2c9Yy7VDX+bb/3GY/q1CKtOWeLQqUhFYTGSdD8rfpAYz8U0xbDFVKdZOtakiXhalFBTXsM83WZJqrojNcdIkLcriuXSY0ntiAGcaF9AQ/gPUaF98bzbXYbSncMAlV4BDMSinp8w/lKa+Apb2i3FOc0RXvTIpQxdxHMCrMvcqozcgYgtddlV1+tatJz660IJDobx8bcbue33xHSj7QRqrD9+uYr7uuPZXAE08psrNermHeRBklcOLfXzcPNUMRnOpZxuBb4fcKhbCDtbjrcFFoc6ZktyZEcD892V4xT+3fHde6R71Urx6XyephAQinR0DvPbaA3083EljBoYLjPCH/1Fdtuni9UK3qgeP5dGqopjugUheZtTjVEWpTJopLBcLSFwa0+/qzVQdaFBj+IssEAgC3GldSEZfiudLesZmaFcYdgtRmVL8+wys/q4tu+vF7yHL65KuljEIm3JNxdObeEgFwivtVuGZuI+foE7cYs5P7DAMC/v/m+CevgEs5zUbVv32WB39lUuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(86362001)(26005)(478600001)(186003)(5660300002)(7696005)(8936002)(66946007)(9686003)(6916009)(55016002)(966005)(316002)(53546011)(76116006)(52536014)(6506007)(8676002)(71200400001)(2906002)(4326008)(54906003)(66476007)(66556008)(33656002)(66446008)(83380400001)(7416002)(107886003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Eaqjbj+lipFWpzK4w16qqtmBJara4hOCxTnFdWqnJTQGCvUhSUncSVsnvVdQ?=
 =?us-ascii?Q?RGxfkQ1FCrIthgF7vaaYBSfDRtIYX+t+mu4K3QDovl2U25xXNa9iFHTWn3UO?=
 =?us-ascii?Q?rkwhYHL7BQlMoEM49x5HHu86dYyivgstURdz+g2rh7a2U0Jf5vgBRJUnTwYS?=
 =?us-ascii?Q?5l892Xl1nqar7nEEprYiUbZvFdNMePEjQl/rzaSRK/lzxFtjbL5YB9n5eN4Z?=
 =?us-ascii?Q?GjzQnGNSlFFv9Zm0lL3XDpuUnmgKTqhx5iWZ8MTsW6yWxsyTlvWXCbw9kJzK?=
 =?us-ascii?Q?YbMQHwmjCmxSLtZVBhQd09RgwdlM2FMqw+5+oSIKCuNyo8mffd7hqU8sDdMY?=
 =?us-ascii?Q?fJMrMpQCc6RtZL1Ic2hr5Bey/fYx/D84lTzg668jdTqmmSF6c5W/4aSLnd0x?=
 =?us-ascii?Q?stzXi0xFyfGQBfOt5mZGquE9n8N5i6f/a5F3XL9wV3D2iQYNzNUyRgxW47n4?=
 =?us-ascii?Q?PVoDSPJwQr80x13WRFu/BfKF8YFUaxQhKZwJAOnk8v5tYdEdLW1q8Rvt0c/K?=
 =?us-ascii?Q?kJZnxQoUty+d5Ehn8xDlikXvzBu99ijG242Xq+5v+bavak8edaWoSfqHF4vG?=
 =?us-ascii?Q?XGNTkG5qJhgw/GBYVAgcC8eK2Gix87V8lXjncEtCoy7qSLJZ8365JYndJVRp?=
 =?us-ascii?Q?yTCR3JXJ9SJCLbWztW4pQlcqZE3xjuQQzicP9NEIOP9MfP7MG/s/NcFUvZUC?=
 =?us-ascii?Q?sl/TnwoPHq+1atjswi17WLoo7yhw7hlP/1H5VLZtvc1TI87B7mPx21ThYWmJ?=
 =?us-ascii?Q?wTEmLyYs0zrORF/xK0lnLBd9Z3u3ftNmvHMzA7E/Y2k80d+rhhVX/QLyfgL0?=
 =?us-ascii?Q?QBbx1IA3fkDCrTyCC2mr3BjXQbCu9nVbTqnQMVjNxQdsVkicJe5FeEgXTNS7?=
 =?us-ascii?Q?zSu2eY8NEcq0U72uVIxEiqbXQuMOGlb+ACHtCjiHMGzkF4u1E3Eo8w4GTTV6?=
 =?us-ascii?Q?aKMN4903OIJXLyjEmD+aTzr5IX5SyYviNaGeHfO71PwyGZDe4wHIv4iN9Pe6?=
 =?us-ascii?Q?Pp8Bnht7UJcBg5vIpdj1eHahh0Wpf7jtGCIAjuxpOxiR+TqB3SKFDDOOt4s6?=
 =?us-ascii?Q?VNnS0sSRzt/LE3dpnj+RulxeKFkzdQa4QjQ+maTWUSF4m8/VvliwlqC6w7vK?=
 =?us-ascii?Q?4BYBDCzWnBrdjMUo5ln9PIYrS6xBjzeEdHUpk0+e6tfS37V5G99uodC77MeV?=
 =?us-ascii?Q?w/y9u/mqhNjGZqqpLQO3gV/i8AX7eqmzBgDRezBN/91siW1n13Ggjc5DQPlU?=
 =?us-ascii?Q?JiUVu3T97m5KKVHUWVDPvwmIFVxhm+QkCmkKvgywaFY7EoorLgo/M3XlKVCk?=
 =?us-ascii?Q?ywqt2VJWiq3JvZODil/5mHi7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90d091c-491a-4ac7-5acf-08d8cf1d5377
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 06:13:33.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnOJzMEkbxO0waPZqX/t60SqcQ1mvRz5La6YXvP/U10YeovIMlDieVmMEK4VZpEDdGOq62oT32NejmKFLua8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7602
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob,

Please find my response inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, February 11, 2021 8:26 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org; mdf@kernel.org; linux-
> fpga@vger.kernel.org; git <git@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; devicetree@vger.kernel.org; robh+dt@kernel.org;
> chinnikishore369@gmail.com; linux-kernel@vger.kernel.org;
> trix@redhat.com; Michal Simek <michals@xilinx.com>
> Subject: Re: [PATCH v2 2/3] dt-bindings: fpga: Add binding doc for versal=
 fpga
> manager
>=20
> On Thu, 11 Feb 2021 11:35:31 +0530, Nava kishore Manne wrote:
> > From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> >
> > This patch adds binding doc for versal fpga manager driver.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > Signed-off-by: Appana Durga Kedareswara rao
> > <appana.durga.rao@xilinx.com>
> > ---
> > Changes for v2:
> >                 -Fixed file format and syntax issues.
> >
> >  .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:12:14:
> [warning] too many spaces after colon (colons)
> ./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:20:9:
> [warning] wrong indentation: expected 10 but found 8 (indentation)
>=20
> dtschema/dtc warnings/errors:
>=20
> See https://patchwork.ozlabs.org/patch/1439305
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

Initially, I couldn't see any issue when I run.
After installing yamllint and with upgraded dt-schema, I am able to reprodu=
ce the above pointed issues.
Is there any prerequisite(Other than yamllint) I need to follow to run dt-s=
chema?

Regards,
Navakishore.
