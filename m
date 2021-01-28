Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145F9306CAC
	for <lists+linux-fpga@lfdr.de>; Thu, 28 Jan 2021 06:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhA1FRj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Jan 2021 00:17:39 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10696 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhA1FRj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 28 Jan 2021 00:17:39 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10S5BJGL002988;
        Thu, 28 Jan 2021 00:16:43 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 368nsddh58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 00:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqQyWmoJo7XHF18Qv68CS/uYlD0ePaaPTtMr1NU7qTwVsJtvi54WaJr8NURiIHERzXmVUz8rgyojJh+7C+vs4LI60fcAdgCmbc63RW8/bZxFzjHqMp/n9cAHIoyR2mS6pxDljPb0EYMeEJ3aI18xlAUGUg3dMpJGaJv6W/Z+o/PGugCJeTf8OTFrto85bTKEUQGTTMWyuWwLfJINl3lr75kTShu5yoEC8ZAXdzyKg99MDNHWx0sueFtJxBb7Sjj4QcTKjMp/nhIBHN/fQuUei4oesv2Y56zT/vhA7JBGAOGS/kwIoqxXWSIEADqve9io64rFRGr6ZgAHaZLoONIj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7lSgOo8SQRBeJoXoZEEveXTMMOEqVrmwsBg549k9YE=;
 b=Gjm6twzIYtQn3sk1v7KIKfvU8VbteDZ8wTTbQcHDg3YhrmOlFXSTiziYeVYb7BOhDZ4eZg9ya/SsdUJCUIVaBDBgm5I6bgh+OgCPhfUL+7l39kGeG4aZeU993Q8/HDH7ZAnSzssMznptQ9bhmWK4XAcPsrGe+PogYVrPO5ivqsi4cJHT1/pybe6sCkoLj5XoEu2pENjCPDGCLMAyqDf5wyThP9L0Yo9//gazBGpHHzrIrK+SfZpWBJAF66y4JLCBhmv+vp2bik/hD0rPZPGO+c2J3N5W7N2Zl+vo3qSElFaoABYaEWTdQewgebr6ohfBAClS8sdFTlcsVDtAIaBAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7lSgOo8SQRBeJoXoZEEveXTMMOEqVrmwsBg549k9YE=;
 b=mI5rPYLFFvWNJJ5daKrYwCv0U+tyo1DiHfNWEowY69n1TfifXyyd9ns7KT/7aJmUzGTqzSBHRgfOMXOmQCKG1MvgTYxQ4lO7ro4ZM/byG4se6W87J5GENGIgLAuraWBOEtp+uWI6Z1oO9JU/JoT/D3WucutUJp2bbx26wrAkRCM=
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DM5PR03MB3083.namprd03.prod.outlook.com (2603:10b6:4:3d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 05:16:36 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::e4d2:490d:16b2:25aa]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::e4d2:490d:16b2:25aa%5]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 05:16:36 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v2 1/3] clk: axi-clkgen: remove ARCH dependency in Kconfig
Thread-Topic: [PATCH v2 1/3] clk: axi-clkgen: remove ARCH dependency in
 Kconfig
Thread-Index: AQHW89M2fvkHlXIPW0GheGUW3qYMMao6w3OAgAG+QQA=
Date:   Thu, 28 Jan 2021 05:16:36 +0000
Message-ID: <DM6PR03MB51969FF855E3216A2173D7EBF9BA9@DM6PR03MB5196.namprd03.prod.outlook.com>
References: <20210126110826.24221-1-alexandru.ardelean@analog.com>
 <20210126110826.24221-2-alexandru.ardelean@analog.com>
 <YBDSPVgmqD2JvPbk@epycbox.lan>
In-Reply-To: <YBDSPVgmqD2JvPbk@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWFyZGVsZWFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0wMjM0MjE0Yy02MTI4LTExZWItYTYwMi00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcMDIzNDIxNGUtNjEyOC0xMWViLWE2MDItNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIyMzMzIiB0PSIxMzI1NjI4NDYwMzg2?=
 =?us-ascii?Q?NDUzMzciIGg9Iml1S2dBcjV5RFBvV1NaN1pBWGM3N0VKdnRQND0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUlZREFB?=
 =?us-ascii?Q?QlpXb3pFTlBYV0FRK3BEbW9sYlhyVUQ2a09haVZ0ZXRRRkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBcWNicENnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJ?=
 =?us-ascii?Q?QWFRQmhBRjhBWkFCcEFHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJs?=
 =?us-ascii?Q?QUhJQU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tB?=
 =?us-ascii?Q?WXdCMEFHa0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51dbbef3-c3ce-4486-271a-08d8c34be276
x-ms-traffictypediagnostic: DM5PR03MB3083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR03MB3083E81B3E1679E0C851D355F9BA9@DM5PR03MB3083.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dHdlIjC71p5gQBrdxsyZ8CTX86ZJXrY7ejRefNGB0c/tCx/+REvPAD42PxK2KHYjlldE8OjQye6CFUHWVhdppTllC1oOa5SUoUDSufGyVUZZygeFhyEls+Fv6BRH+Y5dWgZf4ynm9Xh0hsE2bOu5Ff9m5X9y4Js+NR84Rrg3wGcdDTCJJrmC/p9JWW5Rp5E5n/j+XpNpyKuIhVGMkGQ4tdGHXeTBGVK0mquwZabP/elAFRY2Fei3cnEgLYzHCw03UZ2EoipdVAAz10GQlnez5W1YhoUMHqydUrIafHW8n8ciSnZY4NYa2vXQU1D6pV4tTfPD7jP5cw5egTSyVnp6E4xxe1/qF3JCLMT+gYeVgz3ODJH7b4Mx+huQCrnLkPwPxaSvGuKMQr2vnd9trVei4fvCtobWYNQWBrV70rslycO9ddobXWQBfhXCNtFOmVx1GOKZaCysPhn+tBHigdFCIhKOJGvEDliShvdalVu/ZmTdplwPS7eJ36wp8bCysHQg6GPtcxMsQYJxdurz8NeVVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(53546011)(6506007)(6916009)(8936002)(71200400001)(186003)(26005)(5660300002)(316002)(83380400001)(54906003)(7696005)(8676002)(66476007)(76116006)(478600001)(55016002)(33656002)(4326008)(9686003)(86362001)(107886003)(64756008)(52536014)(2906002)(66446008)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XUg+GwBZEARMeTsFW4EEId5zxqKFbtoT/gF5jNh0nZuQ+XcWyL9fNW+ZUb5/?=
 =?us-ascii?Q?QmKH17oBgMOtE4DjnGNRz7pps7xOBlQhePFQF4Il2XaGYQCKMAF+hl3RWulN?=
 =?us-ascii?Q?UbaKez7hr8zf+4jZgH9vMdU3HWIHjTCG2xL9YVPDqi86Cn2MlZzH0ipH9b1D?=
 =?us-ascii?Q?wXxywm31CTlnpLvfpadVmrczza8yhztyArff3Yq37mpfBSyqjXoMo4mPwcv7?=
 =?us-ascii?Q?Ve1Lt5bmtz/ZMZVnYD24u1xYmQZgO/UNjdMwxEHxmq7qDxFVrZxbSJIFPM1A?=
 =?us-ascii?Q?1sFl/IP5GbEw8iwi3ljOChVeT2gdeW8wOIjvEtzlYZK0z8cicQGgd2ghDh2d?=
 =?us-ascii?Q?VnoMp9qABJTEKbn52xtScIBIUYN6rmdqpQcEG9jqa7khJaHiyU4OJH2Ys/Uu?=
 =?us-ascii?Q?dueI7rc8PGCY74gM/ZwacaYV2z4U0kyqlhxUK+nzRC1sblVQadX1/qo2MLrb?=
 =?us-ascii?Q?BwxzqNsoNGG+DuGEmI1eRt0oT8lRy/I38apqKQf4vOsUW6mqhuxtfcSaLjNM?=
 =?us-ascii?Q?qX2Ke/kmPM/ZYspAYThBT2AUxieu8EwNTTtm9JaQqjq/QhIEGd3bur9i2uic?=
 =?us-ascii?Q?e20ZLUHVWrFoUiXWiNG28BIuVQjZ5yvfo2wT1AYotb6UQNiXQCwxQaHcxIrm?=
 =?us-ascii?Q?jsJ3TqWb81F/42IQ8SvyTgZt/pBRb1FPloil52rGZerktv2MPxQbDQQg+LBS?=
 =?us-ascii?Q?6ZnDGpHRuH89Cpbw2SX2hAwMWxRAZUiUX3iyuh2V2B6ImSiyXq/rjlucJh8d?=
 =?us-ascii?Q?Vk+hm/ZsZ2xrDNJPP/syJvhQq6VMxQzzEG9IIMji9y3GYet48UVT4p+LbQc9?=
 =?us-ascii?Q?J1i02MErohpjoalzUncxQC2HPSwHYrPP6+Ga8c0kOiNM1jj50xO3uySc2kY6?=
 =?us-ascii?Q?VN41DfPEgroKR97wLwxWSDYYmXWhGn0E4iE9CT6oqlSkcH/krSmM6/va8L1Y?=
 =?us-ascii?Q?jvYlfOLZ50sZ+bl3srepvf6v1b0GpYyM3x1yelM4ibt5TI9bKtnwoum5Zuph?=
 =?us-ascii?Q?fROpqtZTh7NoiY7vl3MX75BZSBhEIAdBykp1LfSyujzA+9R+vC8Eu/rli9nQ?=
 =?us-ascii?Q?unxuKY9W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dbbef3-c3ce-4486-271a-08d8c34be276
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 05:16:36.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeFqxcAPTnPHSJRkkYhjzOuSjooZGAyi4gVMx0qk4alwKpcTOVwOaItnDikhZQitO2UqKtdXPaIKMRjloo0jFDw+j7/1/S9kzjbgKGo1jdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3083
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_01:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280025
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Wednesday, January 27, 2021 4:39 AM
> To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
> Cc: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; mturquette@baylibre.com; sboyd@kernel.org;
> robh+dt@kernel.org; lars@metafoo.de; linux-fpga@vger.kernel.org;
> mdf@kernel.org; Bogdan, Dragos <Dragos.Bogdan@analog.com>
> Subject: Re: [PATCH v2 1/3] clk: axi-clkgen: remove ARCH dependency in Kc=
onfig
>=20
> Alexandru,
>=20
> On Tue, Jan 26, 2021 at 01:08:24PM +0200, Alexandru Ardelean wrote:
> > The intent is to be able to run this driver to access the IP core in
> > setups where FPGA board is also connected via a PCIe bus. In such
> > cases the number of combinations explodes, where the host system can
> > be an x86 with Xilinx Zynq/ZynqMP/Microblaze board connected via PCIe.
> > Or even a ZynqMP board with a ZynqMP/Zynq/Microblaze connected via PCIe=
.
> >
> > To accommodate for these cases, this change removes the limitation for
> > this driver to be compilable only on Zynq/Microblaze architectures.
> >
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/clk/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> > 85856cff506c..d8c2d4593926 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -247,7 +247,6 @@ config CLK_TWL6040
> >
> >  config COMMON_CLK_AXI_CLKGEN
> >  	tristate "AXI clkgen driver"
> > -	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
> Umhhh ... no dependencies? How are you accessing your registers? You seem=
 to
> be using device tree, probably:
>=20
> 	depends on HAS_IOMEM || COMPILE_TEST
> 	depends on OF
>=20
> at least? Please double check your dependencies.

Agreed.
Will re-spin.
This is a n00b mistake on my part

Thanks

> >  	help
> >  	  Support for the Analog Devices axi-clkgen pcore clock generator for
> Xilinx
> >  	  FPGAs. It is commonly used in Analog Devices' reference designs.
> > --
> > 2.17.1
> >
>=20
> - Moritz
