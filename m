Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5022268D2BF
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjBGJYa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Feb 2023 04:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBGJXx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Feb 2023 04:23:53 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58162EB6F;
        Tue,  7 Feb 2023 01:23:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwaXDj/MkoBV9C58c/EZRtdkYfhAHw3rP9kwkdCtSG+dRMlajZjuaHFEDfQR2wBBkmyuxOtdwFKDpeQqvxLrmRmoRQAah2/fHHuK7TLebv1R/ugfLD1kdkyUC+xbC+0XzEAWA7Et4LiCyOs43bWWyzwSlH77jwiuKMLtl05wIqjy3htGQRPX/0aoyD3Alz2rICtG0PYFrBUarIvftMh7I6ICUzjdkB4ZqcdMcM5Q0E8AlKByGj9442KBXIgNJ0en5LndW5affFlps5Hz2V6p6RV6dmx9cpM45v4UnxIOyqSgHA/dIUk4qgS/JBvgveO36eUm1wIscmIL6T3h/IHJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DSNhJ6b+s87OfDrWy7tYveklgmViEqwmr77f12hKnU=;
 b=ABiTr+9OLEjaLt5lmI3j+rUVygsdVsE9j2kj/OpXaTbqjggeSsqMGsUD34y03PgYwABUydMLUQNejbDbIMsouMSBRcivecpggo2BMXzP3vbe+6OQgzX/nVoxim00fBxMC4Kid/qKRnupqCQAhNroOlx3bgk96VlYyyyRRjUm5Wpe5tcWmyrUY2UNl+sH7+mJHV6IHfr4AlH3oatWTLRAjGXvZvWGn/0zOBIw+2XaO0Pr8QgUfB/AepYi057KmiB7JLZayJDuBsY9cKlmfWB9e9VTNg6yaXOPWBGkLChzha9h7n+vbKBzoRUiiBqgWYc7qOPYmEU9R69YwUlVlJEWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DSNhJ6b+s87OfDrWy7tYveklgmViEqwmr77f12hKnU=;
 b=3jRqfzieQULlrBDwI8D5YmHgZZxihghinBrSG+Oxuvadq7Z/rvMnvqs4VtI9WLxyQXqpiwkMTVdMjsAExKKdIK0cUrb/UixBhp3X2YUKmWTAF3POLd9gMHavkiBg7Q5NFSMJ2JY+aD1xq0VMQB5f1TYtbzSpwvBe8r+LZlscpQc=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 09:23:13 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::cf25:1ed8:5dd0:104d]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::cf25:1ed8:5dd0:104d%5]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 09:23:13 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "tanmay.shah@xilinx.com" <tanmay.shah@xilinx.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] fpga: zynqmp-fpga: Adds status interface
Thread-Topic: [PATCH v5 2/2] fpga: zynqmp-fpga: Adds status interface
Thread-Index: AQHZNVkp73EU2R5VmU2aNqwbd25YNK64Z4mAgArLZGA=
Date:   Tue, 7 Feb 2023 09:23:12 +0000
Message-ID: <DM6PR12MB39931368F0863BBBF22BC806CDDB9@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
 <20230131094810.1945541-3-nava.kishore.manne@amd.com>
 <Y9j+rZQkiPcIPxOr@kroah.com>
In-Reply-To: <Y9j+rZQkiPcIPxOr@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|SN7PR12MB6766:EE_
x-ms-office365-filtering-correlation-id: 7d90506a-de8b-4905-b3d5-08db08ecef99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4d9O+spDimqrx3W2i/2Ec66Xlh6exGRSmGXbPk8QrL6M5HjKPedC8DWVUxT7GBgduK31SHFJh+KelMQi4VJmuH1eJwUVC3YSr+qBVCh7E9F5MiBtcTr3QNIkslI4SVJ465JXWhqspAhmqwgYawyOzUmx9wpqeXAor3UwbvzFaYipN5JAP0s2zk65YAo7uDaZMC+WqkEw6rUPHjlZFgjZ391gugusfPPj1swSZ1eoDJDLqZpn7qvK9eqO6qmgIIzXuIoRhn31hap18wxqRuD2pcvEh4Ly+oE0fjORXImTWnY6/ZrNK4ILcpYXYbiurnjGBZYh096DvSvv+K0ZLV7xUYs/K39nDRktlnGz+KseuKjhKMU6Cy1XqqhGfWsNAtE1tdfaMe2FTHGTE/r57YiOr74CsjNgaPdfBqjmLXMywipAIHDo7dKV6QCUrFpSyEwhHjpBol1x2dkLPnTxi3PXrkaWF1+0YAZ+sdQJrppuLPM2eseEt/FS1Swz52RPmN2HO4gaEHRKLdK8o+YPsbZJx6Vj/Y9SXRImKJJnyKOAr5ZkTmJc+0hyi1dY+VMW2jgVObRdBbZcqDXRnFUBFilUrLg/s411UPqkMqzlsFImSeK36ncceTCWDkr2e0EuY9fPpLp4xtr8XARNfMttYDzo6IELGUZplgUato4kpOPVe6eQKpzGEAWT9ZG8xwimiUrtqXrt4BvOtyUhddvDi0shmvN4lADl2eAW3c79qIAHDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(9686003)(53546011)(71200400001)(26005)(6506007)(186003)(7696005)(38070700005)(478600001)(83380400001)(38100700002)(122000001)(33656002)(66446008)(66556008)(86362001)(41300700001)(8936002)(110136005)(66946007)(55016003)(54906003)(316002)(76116006)(8676002)(4326008)(64756008)(5660300002)(52536014)(66476007)(2906002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LfBKdTWXZ/YdxlHO7YXs2UIMFuqY2i8NvWSfdYQiFpSjmE20acVu0CeVf+D9?=
 =?us-ascii?Q?DRQPY2OXpsfDNQpuV7fToh7edcIELrYZO16lYCF6OXBcMZxK/p9ECki55wjd?=
 =?us-ascii?Q?BeS2679vP6wcuyb+gXCp6XRFy4Hto6LmJGmf1VppBpkR0iaAhX5z8g/cQufY?=
 =?us-ascii?Q?QkChfxz3b5qlrnxSaRTxgGjPmpQuebc88uye+EYlqjdR7xnYV0XPSjdnoWZF?=
 =?us-ascii?Q?ubgPixV3qBASNJnXR6+O64qr+s7zVqVoDk9VGkGGp/r4BzwUfxaZcNzAKicx?=
 =?us-ascii?Q?xVwNg+NXXEPmmW2qd1byENP5XjQiEo2h6uDihC0/oKOPUrZ/ATxiE/br4TAX?=
 =?us-ascii?Q?oWIyXOwe9Kwan9hJBYBlr23Bnr5eATO7lPcK43cPA5xsQqmdBR36zMt0fhT/?=
 =?us-ascii?Q?+xwlFQiapBIhbLRr9tdd/R6Ri21Lxgx+JagEjDRKXrT63dr+BQNeUkxBbP7P?=
 =?us-ascii?Q?I+reTpyqoNHuOqMZu3NM+sIsSmMPV4B7rIRx5iqiYrdJNq4cunxtU8zfZAXZ?=
 =?us-ascii?Q?Eq5fzVIKuCJxgwbMTam/HSs99/xJQ7bH3oC/pyNWV0aueizVzffBTjIISudz?=
 =?us-ascii?Q?fQsAtlPOQoLPHuAQmkVgbeXce1OSdcQmR8GZtBcY8KtFs1NtCMdbAvXgGrU/?=
 =?us-ascii?Q?HQfvQkmTO1mEnu4c+LWdRGQQtPgiL/6N3opNsOo4HVVWgPT6Hla+BSuTEFqK?=
 =?us-ascii?Q?eJUtvpcyFuTIuzKPyM+JhjNz6d3JlVfeezV74F/YqF7yWdtX/dWn0FOUBXnv?=
 =?us-ascii?Q?A8+awrk0K/HtVaFS5c2BX/AZAWupv5rSPC60KitXSc6ywsihfboaKS4M2/MV?=
 =?us-ascii?Q?Cl1LBLZGQPrGn4MQ4oMQTlaUO7Ancj5L4Zgij+2ZSXl1m1gr5IlmpszklUAk?=
 =?us-ascii?Q?bMw5gYPxBmHvO6Z23TNh81p0hG5d2XnMnGqof8o47MZvfN37p8/I8emcKpSn?=
 =?us-ascii?Q?hSLRoTS0DWccTJdOZ++aLtUVd9v3Mz1RplTwwZAqhkTlFnmuMEVRVn06roza?=
 =?us-ascii?Q?sZWpP/EezbpsXWXpcN5/kgv4GaCSv/qffCUTbWLGN8TAPKq4Yqr/d4xJzKAq?=
 =?us-ascii?Q?O016/Y9ZSbW1jdT9UJFWkOf1bLjHQnTRNgZmkivG7gFBEDEMqnidmHycs7ag?=
 =?us-ascii?Q?xhawZJNxPqB5fgclYDrJMci3kq2H/jkjXJzNyBFU/9nwR9hhGRqWYLG/aaL/?=
 =?us-ascii?Q?FfpFkgHmqQlo4LnCTRw0aO1xgdSPazoQ3X7wiSS42IwRhFXvqnN1IqAlv3z/?=
 =?us-ascii?Q?XHcCvhkjaS4H2HtLvOLnlrcBGJ52CZcTORiMOVUI4DznBS9xTfqxrhvL0Iva?=
 =?us-ascii?Q?Sco0ksDjJcMQIRI6w3CtYorR6VItyii6HQYL+lFguoxnNoPd+dDRdsf41bk7?=
 =?us-ascii?Q?ivmtZa8CGpR9vUy0xSJUge8wN2ra8/RNRtoR+Xk5OdLC6+UfuEhPL+ETs6j5?=
 =?us-ascii?Q?3n2Ox2JHxEXPz6tlzAKJDDRYLe3FuQ0ILj8na6DG4/PF/rYcPiSQVfOjHgEK?=
 =?us-ascii?Q?v6ILvkcCFRFo8vhf1Q67sXKvXFQuAXyW84lgnDukXIp2Ov6hIKfnmKjU1PYH?=
 =?us-ascii?Q?4bqjXv6+qwvmyrLDfag=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d90506a-de8b-4905-b3d5-08db08ecef99
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 09:23:12.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXmw4iy5OKhfmSTTiKygTycSWdmm8IZmeUIGNbYA26nhQG34Bzh4at45LXpryh+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 31, 2023 5:13 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: michal.simek@xilinx.com; mdf@kernel.org; hao.wu@intel.com;
> yilun.xu@intel.com; trix@redhat.com; ronak.jain@xilinx.com;
> tanmay.shah@xilinx.com; Levinsky, Ben <ben.levinsky@amd.com>;
> rajan.vaja@xilinx.com; harsha.harsha@xilinx.com;
> mathieu.poirier@linaro.org; lakshmi.sai.krishna.potthuri@xilinx.com;
> arnd@arndb.de; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-fpga@vger.kernel.org
> Subject: Re: [PATCH v5 2/2] fpga: zynqmp-fpga: Adds status interface
>=20
> On Tue, Jan 31, 2023 at 03:18:10PM +0530, Nava kishore Manne wrote:
> > Adds status interface for zynqmp-fpga, It's a read only interface
> > which allows the user to get the Programmable Logic(PL) configuration
> > status.
> >
> > Usage:
> > To read the Programmable Logic(PL) configuration status
> >         cat /sys/class/fpga_manager/<fpga>/device/status
> >
> > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > ---
> > Changes for v2:
> >               - Updated status messages handling logic as suggested by =
Xu Yilun.
> >
> > Changes for v3:
> >               - Updated status interface handling logic (Restrict the s=
tatus
> >                 interface to the device-specific instead of handled by =
the core)
> >                 as suggested by Xu Yilun.
> >
> > Changes for v4:
> >               - Limit the error strings to one word for each as suggest=
ed by
> >                 Xu Yilun
> >
> > Changes for v5:
> >               - Added new sysfs-driver-zynqmp-fpga file.
> >
> >  .../ABI/testing/sysfs-driver-zynqmp-fpga      | 18 ++++
> >  drivers/fpga/zynqmp-fpga.c                    | 87 +++++++++++++++++++
> >  2 files changed, 105 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> >
> > diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> > b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> > new file mode 100644
> > index 000000000000..66c98bb8dfba
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> > @@ -0,0 +1,18 @@
> > +What:		/sys/class/fpga_manager/<fpga>/device/status
> > +Date:		Jan 2023
> > +KernelVersion:	6.2
> > +Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
> > +Description:	Read fpga status as a string.
> > +		If FPGA programming operation fails, it could be caused by
> crc
> > +		error or incompatible bitstream image. The intent of this
> > +		interface is to provide more detailed information for FPGA
> > +		programming errors to userspace. This is a list of strings for
> > +		the supported status.
> > +
> > +		* CRC-Error		- CRC error detected by hardware.
> > +		* Security-Error	- Security error detected by hardware.
> > +		* Initialization-Error	- Device Initialization error.
> > +		* Internal-Signal-Error	- Device internal signal error.
> > +		* I/Os-High-Z-state	- All I/Os are placed in High-Z state.
> > +		* Sequence-Error	- Device start-up sequence error.
> > +		* Firmware-Error	- Firmware error.
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index c60f20949c47..81d3e18527ee 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -15,6 +15,37 @@
> >  /* Constant Definitions */
> >  #define IXR_FPGA_DONE_MASK	BIT(3)
> >
> > +/* Error Register */
> > +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
> > +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
> > +
> > +/* Signal Status Register */
> > +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
> > +#define IXR_FPGA_GST_CFG_B		BIT(5)
> > +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
> > +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
> > +
> > +/* FPGA error status. */
> > +enum {
> > +	ZYNQMP_FPGA_STATUS_CRC_ERR,
> > +	ZYNQMP_FPGA_STATUS_SECURITY_ERR,
> > +	ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR,
> > +	ZYNQMP_FPGA_STATUS_SIGNAL_ERR,
> > +	ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR,
> > +	ZYNQMP_FPGA_STATUS_EOS_ERR,
> > +	ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR,
> > +};
> > +
> > +static const char * const zynqmp_fpga_error_statuses[] =3D {
> > +	[ZYNQMP_FPGA_STATUS_CRC_ERR] =3D "CRC-Error",
> > +	[ZYNQMP_FPGA_STATUS_SECURITY_ERR] =3D "Security-Error",
> > +	[ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR] =3D "Initialization-Error",
> > +	[ZYNQMP_FPGA_STATUS_SIGNAL_ERR] =3D "Internal-Signal-Error",
> > +	[ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR] =3D "I/Os-High-Z-state",
> > +	[ZYNQMP_FPGA_STATUS_EOS_ERR] =3D "Sequence-Error",
> > +	[ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR] =3D "Firmware-
> Error", };
> > +
> >  /**
> >   * struct zynqmp_fpga_priv - Private data structure
> >   * @dev:	Device data structure
> > @@ -77,6 +108,54 @@ static enum fpga_mgr_states
> zynqmp_fpga_ops_state(struct fpga_manager *mgr)
> >  	return FPGA_MGR_STATE_UNKNOWN;
> >  }
> >
> > +static ssize_t status_show(struct device *dev,
> > +			   struct device_attribute *attr, char *buf) {
> > +	unsigned long status =3D 0;
> > +	ssize_t len =3D 0;
> > +	u32 reg_val;
> > +	int ret;
> > +	u8 i;
> > +
> > +	ret =3D zynqmp_pm_fpga_get_config_status(&reg_val);
> > +	if (!ret) {
> > +		if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> > +			status |=3D ZYNQMP_FPGA_STATUS_CRC_ERR;
> > +		if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> > +			status |=3D ZYNQMP_FPGA_STATUS_SECURITY_ERR;
> > +		if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> > +			status |=3D ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR;
> > +		if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> > +			status |=3D ZYNQMP_FPGA_STATUS_SIGNAL_ERR;
> > +		if (!(reg_val & IXR_FPGA_GST_CFG_B))
> > +			status |=3D
> ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR;
> > +		if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> > +			status |=3D ZYNQMP_FPGA_STATUS_EOS_ERR;
> > +	} else {
> > +		status =3D
> ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
> > +	}
> > +
> > +	for_each_set_bit(i, &status,
> ARRAY_SIZE(zynqmp_fpga_error_statuses))
> > +		len +=3D sysfs_emit_at(buf, len, "%s ",
> > +				     zynqmp_fpga_error_statuses[i]);
> > +
>=20
> Sorry, but no, you can not export a list of strings that userspace is som=
ehow
> going to parse.
>=20
> As this is all a bit field, why not just export the raw hex value instead=
 and let
> userspace parse what bits are set?
>=20

This implementation is align with the fpga core status interface(https://gi=
t.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git/tree/drivers/fpga=
/fpga-mgr.c?h=3Dfor-6.2#n632)
I Agree to export the raw hex value instead of multiple error strings.
In case of exporting the raw hex value for status can we update this fpga-m=
gr.c core file (status_show() API)=20
instead of creating individual sysfs file per driver/device? and with this =
proposed implementation
will also fix the issues/Limitations with generic status interface.

Existing limitation with the generic fpga status interface:=20
Different vendors have different error sets defined by Hardware. If we alwa=
ys define the new bits when we cannot find an exact 1:1
mapping in the core the 64 bits would soon be used out.=20

Xu Yilun: Can you please share your thoughts here? =20

Regards,
Navakishore.
