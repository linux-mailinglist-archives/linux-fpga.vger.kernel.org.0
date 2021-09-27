Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981B741A33B
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 00:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhI0WqR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Sep 2021 18:46:17 -0400
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:41281
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237716AbhI0WqQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 Sep 2021 18:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQX+zYvGMT7NmXrhsfO4PBIfeby/IP+hrP+Pp7HQ3Ot1x1Pf4diIFu3u2CVsKcQzv05WaoAE0Bp1T45f0UzS+NyghvHBnoNzVd7fShtKyEtas5wP7HKOpgIOPdj9ES6kCfpoOe02qxYnGgY1Pig/IcWQaTBwSHNQsggFfzJ+/hRTH0VtXZ+xpkC6yZHhhY66dk1mpHuqNNg/+ARR4uuiwWZ/5pfXDiLkJy/PC6CuSYyhzfRzoOubOnvfvAcBCNKcKo+3VrNBHKtj0h3EBaHvZPKH+XdBwLRIK7ukiF0F+URTd4uJJWp5L9lXJWbgVz9FMhmHtq2vDQl33msVgdXVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HMTycZ7GidiZ4M6/4jW5S8NaaYS6Uy/Evib9ds9EUgw=;
 b=BpiW6a+fxiQJifDz/UNTdyzbWx+Umb0slN00qtvUEgn+4L+2HrrdJeCDXQtwDb9zXaTjlUk9LtGaOVtiXXsZ0P3sExvlAmL0PTOIVFcZ7kC4KcFhaPh2CdbMy/QOgTBPJaKprp/XnZZUCp2EUXInz2IITp4NwBePJgidzocuf9IDmrrivuhd+/5T57DqbWcdVfX688lQ0nH21nK43ehE39rYvacwPW7KDykSEvXXonQcQr4dI8MlFsHGvIGo3Krc+DXd4TwJyTqfshBaJ9b13Kw6P9BxXO/8+ZR0X2jGvRhdwpNv3whlUorq5y4OvBX0maAeEjAKjm0eNESwpcCDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMTycZ7GidiZ4M6/4jW5S8NaaYS6Uy/Evib9ds9EUgw=;
 b=X64Ex0FIg3Gqj4J0lGb/as1khnsJklFvz8FhDi64eKYih+B9KUbjgKw9aqZpGSbFNL2Z2fU7YJDb6KNciXa1grOY9t7mp0sAi20KOEkSc4xKvhT1qlqIwSRCRCEk/ugMMtn/mPJB/YzQcdN2Yuafcd/K7eok/3rxPdtv7ieEnvM=
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com (2603:10b6:a03:3d9::15)
 by BYAPR02MB4280.namprd02.prod.outlook.com (2603:10b6:a03:5a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 22:44:34 +0000
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::ac20:2659:251c:ca97]) by SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::ac20:2659:251c:ca97%7]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 22:44:33 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhih@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Xu Yilun <yilun.xu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Yu Liu <yliu@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH V9 XRT Alveo 04/14] fpga: xrt: xrt-lib driver manager
Thread-Topic: [PATCH V9 XRT Alveo 04/14] fpga: xrt: xrt-lib driver manager
Thread-Index: AQHXh7hkMnlVlDFjJ02raPeREcOtWat62AIAgANwSICAH79ygIAFwVwAgBTZnMiAAC+ZtA==
Date:   Mon, 27 Sep 2021 22:44:33 +0000
Message-ID: <SJ0PR02MB88452CE42D533A7D13C88503BBA79@SJ0PR02MB8845.namprd02.prod.outlook.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
 <20210802160521.331031-5-lizhi.hou@xilinx.com>
 <9a214e25-65b3-586d-13b6-e37a380dc10e@redhat.com> <YSEthfOlsQ+7JGMN@archbook>
 <b0918d69-bb7a-0e2c-95f2-99714eec545a@xilinx.com>
 <14eb61e8-2a97-5d6a-7bbc-51aac882f3d9@redhat.com>
 <SJ0PR02MB88453F1A2ADEE327C5BBA203BBA79@SJ0PR02MB8845.namprd02.prod.outlook.com>
In-Reply-To: <SJ0PR02MB88453F1A2ADEE327C5BBA203BBA79@SJ0PR02MB8845.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 38820e8c-fb95-8796-7fa0-e83dc2d1d921
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cbc10b7-bb40-45be-8905-08d982086079
x-ms-traffictypediagnostic: BYAPR02MB4280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4280382909887176E46D4D0EBBA79@BYAPR02MB4280.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:198;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgjUgje9DgOTovvXj1nvJHje+tih2tMe9peGvnJx82cxeHcsBwMG5WOyC2VQWJ48L0Pc/Ik3Y/S6FD9iui60gi1c3aH9jL7itNWYO/ZTkg8aEVfmloBhrHlc7jTSvCz5IScDQA6G5btU/6HrxcTwJV8WJ4nC374+E/VTMeSwRT8NDDKw+BvgqLNEXxzjOR3nC5MFO/AKq6rAfEaf43TlrKPpMHkMzjx3Xq+I29xQxjBb88ZSIRAGwXV71VgnaDln8pKbM15q0mP8nR5YGoecG9b4j+qiWPWdqfpca483oEDcVpv8hto6EMe7nWK5XkbbFVpD4MRppzPsrbQH6YoymYrgWVrsOXTBdD18OHUR5dc4l5Jt6rO1t2qsdpnf4rJagrmqLEOTXDGlKFqoHwKyBTAAYcy6/Lo2Pm1JThkVKePgJxr7MTCOE/vNbGIES7QWVcdXJxAcPKJrqvmmtrVr8vLcVHZH8YjPZspX9DykEOjxvUnQ36xhlIDQ4KiFsBoCkJeaYZ2R+qQf7iFlQjf3qJjqrtgyOQaEdQgYKIBIHzKcq5MQluRC+vM27frNbtQTDOF+SshGL636KfHFZU5LCodF4NpUMM3bMsgvMWC8YT5wcfLMgTKxI2t3Senpd7JQUQMMDvvpOXlqp2xHF1zMhCAM6WuRwIZdouixOXKgknkgpSuzHtlL++uZwcVnlAICyvncJrXX6NxUoNq84Rti8NgmwUs4StwGeGETHeH959lyTRjLuQ/fDM9E6Qe2/XQuo2dbna5GkQiH3GO8CeYxrsBJzGfjajzx/yLnZOp9EnIuhgoi18UVIgv4rzrHIWO4Uta+jdYLjXe24OQSwcGdOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8845.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(26005)(53546011)(4326008)(54906003)(52536014)(71200400001)(7696005)(66556008)(64756008)(86362001)(66446008)(2906002)(9686003)(66946007)(66476007)(76116006)(33656002)(508600001)(30864003)(5660300002)(122000001)(38100700002)(83380400001)(110136005)(316002)(8936002)(8676002)(2940100002)(38070700005)(55016002)(6506007)(186003)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?paoBiOXcbi0uBjTtav65svsB5hZZHt4gRya1ogS10zP5FdwDEbJ6J5MOaW?=
 =?iso-8859-1?Q?ewYKYoA1vsLhI63lpb+5Xe1UDTFGbFfUb7RteuBzxdzfp0OaBTA8qg7ZBy?=
 =?iso-8859-1?Q?A3BNILyLjE2gnmlII95a2bQklY1mxpRTNm6166s5pYISc7XXlpDTWbOyCk?=
 =?iso-8859-1?Q?flrYfB7e8mtD2p3HZi7NKSTMmvpRBJe0LONiSG261HZKxHtJaykoVHpn/i?=
 =?iso-8859-1?Q?e4GDx+GnwfTQHm3e5XC5sZvzuIFBvy0N9SBYXQzHoMiKFm0CUICrFRy/Gg?=
 =?iso-8859-1?Q?RQGltlhQfEs6OEx92TJii4kgfG3kQX0i1TDqpIEA8cM1HtZ64dFizDLC0I?=
 =?iso-8859-1?Q?UfhXs9UmMyUgzdyPODlnr8A73FxRMOwuDkXsUc1JiBkrJxx3zj9Hua9jNs?=
 =?iso-8859-1?Q?Dmasx4G8gef4BjCIt67tD5Qbhx7DNjEgr44cFEGmabnrwWZG5iln7hY+7M?=
 =?iso-8859-1?Q?YMcj4zLwzFxT1BSKKL94U+5zxwwX7oXZ5zV470QpTVQ+JS5qEIOAB0BMnK?=
 =?iso-8859-1?Q?lZ57hgbVztUeDjOlSXCQeiH6h6pqPHcyGugzdBvoUYzb07zQboOndzVDJa?=
 =?iso-8859-1?Q?T3yYqWRQJOWF1x93izhaTvC4j8yDCaLz3TSTeK4LWybsfmq6gJRmFZmZjj?=
 =?iso-8859-1?Q?2AWZ65F2D5U09lun5fFHLt6GNF8aKPSAzPmsTqkuxqn2lk/+WY9on7F548?=
 =?iso-8859-1?Q?HvlpBxvxdVbL3SnkzRPxrrZIM5qXrweo4IKlChu4t5oqyVGoaEQCFzVJxk?=
 =?iso-8859-1?Q?gZtijDNWkAF+UiBNz9SQfVX7ts1OQrqh2Arl0sRazeonbPaNP2Ux8q/F25?=
 =?iso-8859-1?Q?6l2h98WYlSn0l+SDhBmlExhAwXt3QDQjbYirMXjVW5NpE8Y8A1WxD0AAdJ?=
 =?iso-8859-1?Q?gRK1JSfZY6AJSjszGwpqyN4Gh4yanXAqoSVmKYW7A4cHd9m2c5qTT5rOL1?=
 =?iso-8859-1?Q?0envWRkRCeLN4YL41uCXfcIrKcaLWKneMmeTUWWFWaYAydPqGCcWuyVNRR?=
 =?iso-8859-1?Q?P4OCPiOrG9elhXp3XKL6gvi3KYS4anG+1xQMoUpoMjrHlpTRiFERYX8CcX?=
 =?iso-8859-1?Q?1OUlC5NwBcSJuevuCBTfPbxn+P80ibsZHSm+nHpDkDg0q/eb4vCIkHKU6F?=
 =?iso-8859-1?Q?gyRGLWB68+CNvOZgoWFa8aOS0k0YJLpeM88wkXAXM/itUiMZwMXN13bCxm?=
 =?iso-8859-1?Q?Dwy7n3KHowTOV0aQSe6W674UaPL4kodcY2wte0U8CuCE76y8pcawW7573n?=
 =?iso-8859-1?Q?wcIRHrMOMq9DtM8s9177h6K89PlngjXjUbQTiAKn3lfh6AaHK7oVOS56yK?=
 =?iso-8859-1?Q?75TYmYCwm8wIIejxtHoPOKGS91hd8o8KhqmNK3KCVV2y9jBi+3JbpSD5FX?=
 =?iso-8859-1?Q?aDYSaKhSdS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8845.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbc10b7-bb40-45be-8905-08d982086079
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 22:44:33.6904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bASlWzFXIvZZo8JYlYVM2PXvf2FZt235Qj/rcNaFpMKUhdgMQ3yAKuDdakivWGT6kNnsNXHWeM8PpAO92icdfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4280
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Moritz,

Hope things are better at your end. We are awaiting your feedback to the V9=
 patch series.

-Sonal

________________________________________
From: Sonal Santan <sonals@xilinx.com>
Sent: Monday, September 27, 2021 3:21 PM
To: Tom Rix; Lizhi Hou; Moritz Fischer; Wu, Hao; Greg KH; Xu Yilun
Cc: linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Max Zhen; Yu =
Liu; Michal Simek; Stefano Stabellini; devicetree@vger.kernel.org; robh@ker=
nel.org
Subject: Re: [PATCH V9 XRT Alveo 04/14] fpga: xrt: xrt-lib driver manager

Hello Yilun,

Welcome as a co-maintainer of the Linux FPGA subsystem! Looking forward to =
working with you.

As you are aware, Xilinx has been working on upstreaming the XRT Alveo driv=
ers to the Linux kernel. Thanks to the feedback from the reviewers over las=
t several months, we have improved the design of our drivers. We are curren=
tly at V9 and awaiting feedback. Will appreciate your help with the review.

-Sonal

________________________________________
From: Tom Rix <trix@redhat.com>
Sent: Tuesday, September 14, 2021 6:27 AM
To: Lizhi Hou; Moritz Fischer; Wu, Hao; Greg KH
Cc: linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Max Zhen; Son=
al Santan; Yu Liu; Michal Simek; Stefano Stabellini; devicetree@vger.kernel=
.org; robh@kernel.org; Max Zhen
Subject: Re: [PATCH V9 XRT Alveo 04/14] fpga: xrt: xrt-lib driver manager


On 9/10/21 2:34 PM, Lizhi Hou wrote:
> Hi Moritz,
>
> (sending it again because rejected by some mail alias)
>
>
> Did you get time to review XRT patch set? Please let us know if there
> are more we need to change.
> We are looking for your comments.

This patchset has been outstanding for 6 weeks to address Moritz'
comments for the v8 patchset of this single patch 4 of 14.

The changes look good to me.
https://lore.kernel.org/linux-fpga/9a214e25-65b3-586d-13b6-e37a380dc10e@red=
hat.com/

Moritz, can you review the changes ?


The xrt patchset starts to enable a whole class of general purpose
datacenter fpga's.

https://www.xilinx.com/products/boards-and-kits/alveo.html

This would be a great feature for the fpga/ subsystem.

Tom


>
> Thanks,
> Lizhi
>
> On 8/21/21 9:44 AM, Moritz Fischer wrote:
>> CAUTION: This message has originated from an External Source. Please
>> use proper judgment and caution when opening attachments, clicking
>> links, or responding to this email.
>>
>>
>> On Thu, Aug 19, 2021 at 05:14:14AM -0700, Tom Rix wrote:
>>> On 8/2/21 9:05 AM, Lizhi Hou wrote:
>>>
>>>> xrt-lib kernel module infrastructure code to register and manage all
>>>> leaf driver modules.
>>>>
>>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>>>> Reviewed-by: Tom Rix <trix@redhat.com>
>>> This was the only patch with requested changes in v8.
>>>
>>> All the changes from v8 have been made.
>>>
>>> They are itemized below with variations on 'ok'
>>>
>>> It is still Moritz's call to accept them.
>> I'll be OOO till 9/4/21. I'll get to it after.
>>
>> - Moritz
>>> Tom
>>>
>>>> ---
>>>>    drivers/fpga/xrt/include/subdev_id.h          |=A0 39 +++
>>>>    drivers/fpga/xrt/include/xdevice.h            | 141 ++++++++
>>>>    drivers/fpga/xrt/include/xleaf.h              | 205 +++++++++++
>>>>    drivers/fpga/xrt/include/xleaf/clkfreq.h      |=A0 21 ++
>>>>    drivers/fpga/xrt/include/xleaf/clock.h        |=A0 29 ++
>>>>    .../fpga/xrt/include/xleaf/ddr_calibration.h  |=A0 28 ++
>>>>    drivers/fpga/xrt/include/xleaf/devctl.h       |=A0 40 +++
>>>>    drivers/fpga/xrt/lib/lib-drv.c                | 318
>>>> ++++++++++++++++++
>>>>    drivers/fpga/xrt/lib/lib-drv.h                |=A0 21 ++
>>>>    9 files changed, 842 insertions(+)
>>>>    create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>>>>    create mode 100644 drivers/fpga/xrt/include/xdevice.h
>>>>    create mode 100644 drivers/fpga/xrt/include/xleaf.h
>>>>    create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>>>>    create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>>>>    create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>>>    create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>>>>    create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>>>>    create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>>>>
>>>> diff --git a/drivers/fpga/xrt/include/subdev_id.h
>>>> b/drivers/fpga/xrt/include/subdev_id.h
>>>> new file mode 100644
>>>> index 000000000000..02df4b939a1b
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/subdev_id.h
>>>> @@ -0,0 +1,39 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + * Cheng Zhen <maxz@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_SUBDEV_ID_H_
>>>> +#define _XRT_SUBDEV_ID_H_
>>>> +
>>>> +/*
>>>> + * Every subdev driver has an ID for others to refer to it. There
>>>> can be multiple number of
>>>> + * instances of a subdev driver. A <subdev_id, subdev_instance>
>>>> tuple is a unique identification
>>>> + * of a specific instance of a subdev driver.
>>>> + */
>>>> +enum xrt_subdev_id {
>>>> +   XRT_SUBDEV_INVALID =3D 0,
>>>> +   XRT_SUBDEV_GRP,
>>>> +   XRT_SUBDEV_VSEC,
>>>> +   XRT_SUBDEV_VSEC_GOLDEN,
>>>> +   XRT_SUBDEV_DEVCTL,
>>>> +   XRT_SUBDEV_AXIGATE,
>>>> +   XRT_SUBDEV_ICAP,
>>>> +   XRT_SUBDEV_TEST,
>>>> +   XRT_SUBDEV_MGMT_MAIN,
>>>> +   XRT_SUBDEV_QSPI,
>>>> +   XRT_SUBDEV_MAILBOX,
>>>> +   XRT_SUBDEV_CMC,
>>>> +   XRT_SUBDEV_CALIB,
>>>> +   XRT_SUBDEV_CLKFREQ,
>>>> +   XRT_SUBDEV_CLOCK,
>>>> +   XRT_SUBDEV_SRSR,
>>>> +   XRT_SUBDEV_UCS,
>>>> +   XRT_SUBDEV_NUM, /* Total number of subdevs. */
>>>> +   XRT_ROOT =3D -1, /* Special ID for root driver. */
>>>> +};
>>>> +
>>>> +#endif     /* _XRT_SUBDEV_ID_H_ */
>>>> diff --git a/drivers/fpga/xrt/include/xdevice.h
>>>> b/drivers/fpga/xrt/include/xdevice.h
>>>> new file mode 100644
>>>> index 000000000000..b40ebe98b54d
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/xdevice.h
>>>> @@ -0,0 +1,141 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *    Lizhi Hou <lizhi.hou@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_DEVICE_H_
>>>> +#define _XRT_DEVICE_H_
>>>> +
>>>> +#include <linux/fs.h>
>>>> +#include <linux/cdev.h>
>>>> +
>>>> +#define XRT_MAX_DEVICE_NODES               128
>>>> +#define XRT_INVALID_DEVICE_INST (XRT_MAX_DEVICE_NODES + 1)
>>>> +
>>>> +enum {
>>>> +   XRT_DEVICE_STATE_NONE =3D 0,
>>>> +   XRT_DEVICE_STATE_ADDED
>>>> +};
>>>> +
>>>> +/*
>>>> + * struct xrt_device - represent an xrt device on xrt bus
>>>> + *
>>>> + * dev: generic device interface.
>>>> + * subdev_id: id of the xrt device. See enum xrt_subdev_id.
>>> ok
>>>> + * name: name of the xrt device.
>>>> + * instance: instance of the xrt device. The xrt device with same
>>>> id can have
>>>> + *           more than 1 instances.
>>>> + * state: current state of the xrt device.
>>>> + * num_resources: The total number of resource for the xrt device.
>>>> + * resource: point to the xrt device resource array.
>>>> + * sdev_data: private data pointer.
>>>> + */
>>>> +struct xrt_device {
>>>> +   struct device dev;
>>>> +   u32 subdev_id;
>>>> +   const char *name;
>>>> +   u32 instance;
>>>> +   u32 state;
>>>> +   u32 num_resources;
>>>> +   struct resource *resource;
>>>> +   void *sdev_data;
>>>> +};
>>>> +
>>>> +/*
>>>> + * If populated by xrt device driver, infra will handle the
>>>> mechanics of
>>>> + * char device (un)registration.
>>>> + */
>>>> +enum xrt_dev_file_mode {
>>>> +   /* Infra create cdev, default file name */
>>>> +   XRT_DEV_FILE_DEFAULT =3D 0,
>>>> +   /* Infra create cdev, need to encode inst num in file name */
>>>> +   XRT_DEV_FILE_MULTI_INST,
>>>> +   /* No auto creation of cdev by infra, leaf handles it by itself */
>>>> +   XRT_DEV_FILE_NO_AUTO,
>>>> +};
>>>> +
>>>> +struct xrt_dev_file_ops {
>>>> +   const struct file_operations xsf_ops;
>>>> +   dev_t xsf_dev_t;
>>>> +   const char *xsf_dev_name;
>>>> +   enum xrt_dev_file_mode xsf_mode;
>>>> +};
>>>> +
>>>> +/*
>>>> + * this struct define the endpoints belong to the same xrt device
>>>> + * ep_name: endpoint name
>>>> + * compat: compatible string
>>> ok
>>>> + */
>>>> +struct xrt_dev_ep_names {
>>>> +   const char *ep_name;
>>>> +   const char *compat;
>>>> +};
>>>> +
>>>> +struct xrt_dev_endpoints {
>>>> +   struct xrt_dev_ep_names *xse_names;
>>>> +   /* minimum number of endpoints to support the subdevice */
>>>> +   u32 xse_min_ep;
>>>> +};
>>>> +
>>>> +/*
>>>> + * struct xrt_driver - represent a xrt device driver
>>>> + *
>>>> + * driver: driver model structure.
>>>> + * subdev_id: id of the xrt device. See enum xrt_subdev_id.
>>>> + * file_ops: character device name and callbacks.
>>>> + * probe: mandatory callback for device binding.
>>>> + * remove: callback for device unbinding.
>>>> + * leaf_call: callback for servicing other leaf drivers.
>>> ok
>>>> + */
>>>> +struct xrt_driver {
>>>> +   struct device_driver driver;
>>>> +   u32 subdev_id;
>>>> +   struct xrt_dev_file_ops file_ops;
>>>> +   struct xrt_dev_endpoints *endpoints;
>>>> +
>>>> +   /*
>>>> +    * Subdev driver callbacks populated by subdev driver.
>>>> +    */
>>>> +   int (*probe)(struct xrt_device *xrt_dev);
>>>> +   void (*remove)(struct xrt_device *xrt_dev);
>>>> +   /*
>>>> +    * If leaf_call is defined, these are called by other leaf
>>>> drivers.
>>>> +    * Note that root driver may call into leaf_call of a group
>>>> driver.
>>>> +    */
>>>> +   int (*leaf_call)(struct xrt_device *xrt_dev, u32 cmd, void *arg);
>>>> +};
>>>> +
>>>> +#define to_xrt_dev(d) container_of(d, struct xrt_device, dev)
>>>> +#define to_xrt_drv(d) container_of(d, struct xrt_driver, driver)
>>>> +
>>>> +static inline void *xrt_get_drvdata(const struct xrt_device *xdev)
>>>> +{
>>>> +   return dev_get_drvdata(&xdev->dev);
>>>> +}
>>>> +
>>>> +static inline void xrt_set_drvdata(struct xrt_device *xdev, void
>>>> *data)
>>>> +{
>>>> +   dev_set_drvdata(&xdev->dev, data);
>>>> +}
>>>> +
>>>> +static inline void *xrt_get_xdev_data(struct device *dev)
>>>> +{
>>>> +   struct xrt_device *xdev =3D to_xrt_dev(dev);
>>>> +
>>>> +   return xdev->sdev_data;
>>>> +}
>>>> +
>>>> +struct xrt_device *
>>>> +xrt_device_register(struct device *parent, u32 id,
>>>> +               struct resource *res, u32 res_num,
>>>> +               void *pdata, size_t data_sz);
>>>> +void xrt_device_unregister(struct xrt_device *xdev);
>>>> +int xrt_register_driver(struct xrt_driver *drv);
>>>> +void xrt_unregister_driver(struct xrt_driver *drv);
>>>> +void *xrt_get_xdev_data(struct device *dev);
>>>> +struct resource *xrt_get_resource(struct xrt_device *xdev, u32
>>>> type, u32 num);
>>>> +
>>>> +#endif /* _XRT_DEVICE_H_ */
>>>> diff --git a/drivers/fpga/xrt/include/xleaf.h
>>>> b/drivers/fpga/xrt/include/xleaf.h
>>>> new file mode 100644
>>>> index 000000000000..f065fc766e0f
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/xleaf.h
>>>> @@ -0,0 +1,205 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *    Cheng Zhen <maxz@xilinx.com>
>>>> + *    Sonal Santan <sonal.santan@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_XLEAF_H_
>>>> +#define _XRT_XLEAF_H_
>>>> +
>>>> +#include <linux/mod_devicetable.h>
>>>> +#include "xdevice.h"
>>>> +#include "subdev_id.h"
>>>> +#include "xroot.h"
>>>> +#include "events.h"
>>>> +
>>>> +/* All subdev drivers should use below common routines to print
>>>> out msg. */
>>>> +#define DEV(xdev)  (&(xdev)->dev)
>>>> +#define DEV_PDATA(xdev) \
>>>> +   ((struct xrt_subdev_platdata *)xrt_get_xdev_data(DEV(xdev)))
>>>> +#define DEV_FILE_OPS(xdev)                         \
>>>> +   (&(to_xrt_drv((xdev)->dev.driver))->file_ops)
>>>> +#define FMT_PRT(prt_fn, xdev, fmt, args...) \
>>>> +   ({typeof(xdev) (_xdev) =3D (xdev);                \
>>>> +   prt_fn(DEV(_xdev), "%s %s: " fmt,               \
>>>> +   DEV_PDATA(_xdev)->xsp_root_name, __func__, ##args); })
>>>> +#define xrt_err(xdev, fmt, args...) FMT_PRT(dev_err, xdev, fmt,
>>>> ##args)
>>>> +#define xrt_warn(xdev, fmt, args...) FMT_PRT(dev_warn, xdev, fmt,
>>>> ##args)
>>>> +#define xrt_info(xdev, fmt, args...) FMT_PRT(dev_info, xdev, fmt,
>>>> ##args)
>>>> +#define xrt_dbg(xdev, fmt, args...) FMT_PRT(dev_dbg, xdev, fmt,
>>>> ##args)
>>>> +
>>>> +#define XRT_DEFINE_REGMAP_CONFIG(config_name) \
>>>> +   static const struct regmap_config config_name =3D {=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
>>>> +           .reg_bits =3D 32,                                         =
\
>>>> +           .val_bits =3D 32,                                         =
\
>>>> +           .reg_stride =3D 4,                                        =
\
>>>> +           .max_register =3D 0x1000,                                 =
\
>>>> +   }
>>>> +
>>>> +enum {
>>>> +   /* Starting cmd for common leaf cmd implemented by all leaves. */
>>>> +   XRT_XLEAF_COMMON_BASE =3D 0,
>>>> +   /* Starting cmd for leaves' specific leaf cmds. */
>>>> +   XRT_XLEAF_CUSTOM_BASE =3D 64,
>>>> +};
>>>> +
>>>> +enum xrt_xleaf_common_leaf_cmd {
>>>> +   XRT_XLEAF_EVENT =3D XRT_XLEAF_COMMON_BASE,
>>>> +};
>>>> +
>>>> +/*
>>>> + * Partially initialized by the parent driver, then, passed in as
>>>> subdev driver's
>>>> + * platform data when creating subdev driver instance by calling
>>>> platform
>>>> + * device register API (xrt_device_register_data() or the likes).
>>>> + *
>>>> + * Once device register API returns, platform driver framework
>>>> makes a copy of
>>>> + * this buffer and maintains its life cycle. The content of the
>>>> buffer is
>>>> + * completely owned by subdev driver.
>>>> + *
>>>> + * Thus, parent driver should be very careful when it touches this
>>>> buffer
>>>> + * again once it's handed over to subdev driver. And the data
>>>> structure
>>>> + * should not contain pointers pointing to buffers that is managed by
>>>> + * other or parent drivers since it could have been freed before
>>>> platform
>>>> + * data buffer is freed by platform driver framework.
>>>> + */
>>>> +struct xrt_subdev_platdata {
>>>> +   /*
>>>> +    * Per driver instance callback. The xdev points to the instance.
>>>> +    * Should always be defined for subdev driver to get service
>>>> from root.
>>>> +    */
>>>> +   xrt_subdev_root_cb_t xsp_root_cb;
>>>> +   void *xsp_root_cb_arg;
>>>> +
>>>> +   /* Something to associate w/ root for msg printing. */
>>>> +   const char *xsp_root_name;
>>>> +
>>>> +   /*
>>>> +    * Char dev support for this subdev instance.
>>>> +    * Initialized by subdev driver.
>>>> +    */
>>>> +   struct cdev xsp_cdev;
>>>> +   struct device *xsp_sysdev;
>>>> +   struct mutex xsp_devnode_lock; /* devnode lock */
>>>> +   struct completion xsp_devnode_comp;
>>>> +   int xsp_devnode_ref;
>>>> +   bool xsp_devnode_online;
>>>> +   bool xsp_devnode_excl;
>>>> +
>>>> +   /*
>>>> +    * Subdev driver specific init data. The buffer should be embedded
>>>> +    * in this data structure buffer after dtb, so that it can be
>>>> freed
>>>> +    * together with platform data.
>>>> +    */
>>>> +   loff_t xsp_priv_off; /* Offset into this platform data buffer. */
>>>> +   size_t xsp_priv_len;
>>>> +
>>>> +   /*
>>>> +    * Populated by parent driver to describe the device tree for
>>>> +    * the subdev driver to handle. Should always be last one since
>>>> it's
>>>> +    * of variable length.
>>>> +    */
>>>> +   bool xsp_dtb_valid;
>>>> +   char xsp_dtb[0];
>>>> +};
>>>> +
>>>> +struct subdev_match_arg {
>>>> +   enum xrt_subdev_id id;
>>>> +   int instance;
>>>> +};
>>>> +
>>>> +bool xleaf_has_endpoint(struct xrt_device *xdev, const char
>>>> *endpoint_name);
>>>> +struct xrt_device *xleaf_get_leaf(struct xrt_device *xdev,
>>>> +                             xrt_subdev_match_t cb, void *arg);
>>>> +
>>>> +static inline bool subdev_match(enum xrt_subdev_id id, struct
>>>> xrt_device *xdev, void *arg)
>>>> +{
>>>> +   const struct subdev_match_arg *a =3D (struct subdev_match_arg *)ar=
g;
>>>> +   int instance =3D a->instance;
>>>> +
>>>> +   if (id !=3D a->id)
>>>> +           return false;
>>>> +   if (instance !=3D xdev->instance && instance !=3D
>>>> XRT_INVALID_DEVICE_INST)
>>>> +           return false;
>>>> +   return true;
>>>> +}
>>>> +
>>>> +static inline bool xrt_subdev_match_epname(enum xrt_subdev_id id,
>>>> +                                      struct xrt_device *xdev,
>>>> void *arg)
>>>> +{
>>>> +   return xleaf_has_endpoint(xdev, arg);
>>>> +}
>>>> +
>>>> +static inline struct xrt_device *
>>>> +xleaf_get_leaf_by_id(struct xrt_device *xdev,
>>>> +                enum xrt_subdev_id id, int instance)
>>>> +{
>>>> +   struct subdev_match_arg arg =3D { id, instance };
>>>> +
>>>> +   return xleaf_get_leaf(xdev, subdev_match, &arg);
>>>> +}
>>>> +
>>>> +static inline struct xrt_device *
>>>> +xleaf_get_leaf_by_epname(struct xrt_device *xdev, const char *name)
>>>> +{
>>>> +   return xleaf_get_leaf(xdev, xrt_subdev_match_epname, (void
>>>> *)name);
>>>> +}
>>>> +
>>>> +static inline int xleaf_call(struct xrt_device *tgt, u32 cmd, void
>>>> *arg)
>>>> +{
>>>> +   return (to_xrt_drv(tgt->dev.driver)->leaf_call)(tgt, cmd, arg);
>>>> +}
>>>> +
>>>> +int xleaf_broadcast_event(struct xrt_device *xdev, enum xrt_events
>>>> evt, bool async);
>>>> +int xleaf_create_group(struct xrt_device *xdev, char *dtb);
>>>> +int xleaf_destroy_group(struct xrt_device *xdev, int instance);
>>>> +void xleaf_get_root_res(struct xrt_device *xdev, u32 region_id,
>>>> struct resource **res);
>>>> +void xleaf_get_root_id(struct xrt_device *xdev, unsigned short
>>>> *vendor, unsigned short *device,
>>>> +                  unsigned short *subvendor, unsigned short
>>>> *subdevice);
>>>> +void xleaf_hot_reset(struct xrt_device *xdev);
>>>> +int xleaf_put_leaf(struct xrt_device *xdev, struct xrt_device *leaf);
>>>> +struct device *xleaf_register_hwmon(struct xrt_device *xdev, const
>>>> char *name, void *drvdata,
>>>> +                               const struct attribute_group **grps);
>>>> +void xleaf_unregister_hwmon(struct xrt_device *xdev, struct device
>>>> *hwmon);
>>>> +int xleaf_wait_for_group_bringup(struct xrt_device *xdev);
>>>> +
>>>> +/*
>>>> + * Character device helper APIs for use by leaf drivers
>>>> + */
>>>> +static inline bool xleaf_devnode_enabled(struct xrt_device *xdev)
>>>> +{
>>>> +   return DEV_FILE_OPS(xdev)->xsf_ops.open;
>>>> +}
>>>> +
>>>> +int xleaf_devnode_create(struct xrt_device *xdev,
>>>> +                    const char *file_name, const char *inst_name);
>>>> +void xleaf_devnode_destroy(struct xrt_device *xdev);
>>>> +
>>>> +struct xrt_device *xleaf_devnode_open_excl(struct inode *inode);
>>>> +struct xrt_device *xleaf_devnode_open(struct inode *inode);
>>>> +void xleaf_devnode_close(struct inode *inode);
>>>> +
>>>> +/* Module's init/fini routines for leaf driver in xrt-lib module */
>>>> +#define XRT_LEAF_INIT_FINI_FUNC(name) \
>>>> +void name##_leaf_init_fini(bool
>>>> init)                                      \
>>>> +{=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
>>>> +   if (init) \
>>>> + xrt_register_driver(&xrt_##name##_driver); \
>>>> + else \
>>>> + xrt_unregister_driver(&xrt_##name##_driver); \
>>>> +}
>>>> +
>>>> +/* Module's init/fini routines for leaf driver in xrt-lib module */
>>>> +void group_leaf_init_fini(bool init);
>>>> +void vsec_leaf_init_fini(bool init);
>>>> +void devctl_leaf_init_fini(bool init);
>>>> +void axigate_leaf_init_fini(bool init);
>>>> +void icap_leaf_init_fini(bool init);
>>>> +void calib_leaf_init_fini(bool init);
>>>> +void clkfreq_leaf_init_fini(bool init);
>>>> +void clock_leaf_init_fini(bool init);
>>>> +void ucs_leaf_init_fini(bool init);
>>>> +
>>>> +#endif     /* _XRT_LEAF_H_ */
>>>> diff --git a/drivers/fpga/xrt/include/xleaf/clkfreq.h
>>>> b/drivers/fpga/xrt/include/xleaf/clkfreq.h
>>>> new file mode 100644
>>>> index 000000000000..005441d5df78
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/xleaf/clkfreq.h
>>>> @@ -0,0 +1,21 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + * Lizhi Hou <Lizhi.Hou@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_CLKFREQ_H_
>>>> +#define _XRT_CLKFREQ_H_
>>>> +
>>>> +#include "xleaf.h"
>>>> +
>>>> +/*
>>>> + * CLKFREQ driver leaf calls.
>>>> + */
>>>> +enum xrt_clkfreq_leaf_cmd {
>>>> +   XRT_CLKFREQ_READ =3D XRT_XLEAF_CUSTOM_BASE, /* See comments in
>>>> xleaf.h */
>>>> +};
>>>> +
>>>> +#endif     /* _XRT_CLKFREQ_H_ */
>>>> diff --git a/drivers/fpga/xrt/include/xleaf/clock.h
>>>> b/drivers/fpga/xrt/include/xleaf/clock.h
>>>> new file mode 100644
>>>> index 000000000000..1379e24fa5d0
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/xleaf/clock.h
>>>> @@ -0,0 +1,29 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + * Lizhi Hou <Lizhi.Hou@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_CLOCK_H_
>>>> +#define _XRT_CLOCK_H_
>>>> +
>>>> +#include "xleaf.h"
>>>> +#include <linux/fpga_xrt.h>
>>>> +
>>>> +/*
>>>> + * CLOCK driver leaf calls.
>>>> + */
>>>> +enum xrt_clock_leaf_cmd {
>>>> +   XRT_CLOCK_SET =3D XRT_XLEAF_CUSTOM_BASE, /* See comments in
>>>> xleaf.h */
>>>> +   XRT_CLOCK_GET,
>>>> +   XRT_CLOCK_VERIFY,
>>>> +};
>>>> +
>>>> +struct xrt_clock_get {
>>>> +   u16 freq;
>>>> +   u32 freq_cnter;
>>>> +};
>>>> +
>>>> +#endif     /* _XRT_CLOCK_H_ */
>>>> diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>>> b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>>> new file mode 100644
>>>> index 000000000000..c44ae30f939a
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>>> @@ -0,0 +1,28 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + * Cheng Zhen <maxz@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_DDR_CALIBRATION_H_
>>>> +#define _XRT_DDR_CALIBRATION_H_
>>>> +
>>>> +#include "xleaf.h"
>>>> +#include <linux/fpga-xrt.h>
>>>> +
>>>> +/*
>>>> + * Memory calibration driver leaf calls.
>>>> + */
>>>> +enum xrt_calib_results {
>>>> +   XRT_CALIB_UNKNOWN =3D 0,
>>>> +   XRT_CALIB_SUCCEEDED,
>>>> +   XRT_CALIB_FAILED,
>>>> +};
>>>> +
>>>> +enum xrt_calib_leaf_cmd {
>>>> +   XRT_CALIB_RESULT =3D XRT_XLEAF_CUSTOM_BASE, /* See comments in
>>>> xleaf.h */
>>>> +};
>>>> +
>>>> +#endif     /* _XRT_DDR_CALIBRATION_H_ */
>>>> diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h
>>>> b/drivers/fpga/xrt/include/xleaf/devctl.h
>>>> new file mode 100644
>>>> index 000000000000..b97f3b6d9326
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/xleaf/devctl.h
>>>> @@ -0,0 +1,40 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + * Lizhi Hou <Lizhi.Hou@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_DEVCTL_H_
>>>> +#define _XRT_DEVCTL_H_
>>>> +
>>>> +#include "xleaf.h"
>>>> +
>>>> +/*
>>>> + * DEVCTL driver leaf calls.
>>>> + */
>>>> +enum xrt_devctl_leaf_cmd {
>>>> +   XRT_DEVCTL_READ =3D XRT_XLEAF_CUSTOM_BASE, /* See comments in
>>>> xleaf.h */
>>>> +};
>>>> +
>>>> +enum xrt_devctl_id {
>>>> +   XRT_DEVCTL_ROM_UUID =3D 0,
>>>> +   XRT_DEVCTL_DDR_CALIB,
>>>> +   XRT_DEVCTL_GOLDEN_VER,
>>>> +   XRT_DEVCTL_MAX
>>>> +};
>>>> +
>>>> +struct xrt_devctl_rw {
>>>> +   u32     xdr_id;
>>>> +   void    *xdr_buf;
>>>> +   u32     xdr_len;
>>>> +   u32     xdr_offset;
>>>> +};
>>>> +
>>>> +struct xrt_devctl_intf_uuid {
>>>> +   u32     uuid_num;
>>>> +   uuid_t  *uuids;
>>>> +};
>>>> +
>>>> +#endif     /* _XRT_DEVCTL_H_ */
>>>> diff --git a/drivers/fpga/xrt/lib/lib-drv.c
>>>> b/drivers/fpga/xrt/lib/lib-drv.c
>>>> new file mode 100644
>>>> index 000000000000..7d21ef565651
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/lib/lib-drv.c
>>>> @@ -0,0 +1,318 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + * Cheng Zhen <maxz@xilinx.com>
>>>> + * Lizhi Hou <lizhi.hou@xilinx.com>
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/vmalloc.h>
>>>> +#include <linux/slab.h>
>>>> +#include "xleaf.h"
>>>> +#include "xroot.h"
>>>> +#include "lib-drv.h"
>>>> +
>>>> +#define XRT_IPLIB_MODULE_NAME              "xrt-lib"
>>> ok
>>>> +#define XRT_DRVNAME(drv) ((drv)->driver.name)
>>>> +
>>>> +#define XRT_SUBDEV_ID_SHIFT                16
>>>> +#define XRT_SUBDEV_ID_MASK         ((1 << XRT_SUBDEV_ID_SHIFT) - 1)
>>>> +
>>>> +struct xrt_find_drv_data {
>>>> +   enum xrt_subdev_id id;
>>>> +   struct xrt_driver *xdrv;
>>>> +};
>>>> +
>>>> +struct class *xrt_class;
>>>> +static DEFINE_IDA(xrt_device_ida);
>>>> +
>>>> +static inline u32 xrt_instance_to_id(enum xrt_subdev_id id, u32
>>>> instance)
>>>> +{
>>>> +   return (id << XRT_SUBDEV_ID_SHIFT) | instance;
>>>> +}
>>>> +
>>>> +static inline u32 xrt_id_to_instance(u32 id)
>>>> +{
>>>> +   return id & XRT_SUBDEV_ID_MASK;
>>> ok
>>>> +}
>>>> +
>>>> +static int xrt_bus_match(struct device *dev, struct device_driver
>>>> *drv)
>>>> +{
>>>> +   struct xrt_device *xdev =3D to_xrt_dev(dev);
>>>> +   struct xrt_driver *xdrv =3D to_xrt_drv(drv);
>>>> +
>>>> +   if (xdev->subdev_id =3D=3D xdrv->subdev_id)
>>>> +           return 1;
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +static int xrt_bus_probe(struct device *dev)
>>>> +{
>>>> +   struct xrt_driver *xdrv =3D to_xrt_drv(dev->driver);
>>>> +   struct xrt_device *xdev =3D to_xrt_dev(dev);
>>>> +
>>>> +   return xdrv->probe(xdev);
>>>> +}
>>>> +
>>>> +static int xrt_bus_remove(struct device *dev)
>>>> +{
>>>> +   struct xrt_driver *xdrv =3D to_xrt_drv(dev->driver);
>>>> +   struct xrt_device *xdev =3D to_xrt_dev(dev);
>>>> +
>>>> +   if (xdrv->remove)
>>>> +           xdrv->remove(xdev);
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +struct bus_type xrt_bus_type =3D {
>>>> +   .name           =3D "xrt",
>>>> +   .match          =3D xrt_bus_match,
>>>> +   .probe          =3D xrt_bus_probe,
>>>> +   .remove         =3D xrt_bus_remove,
>>>> +};
>>>> +
>>>> +int xrt_register_driver(struct xrt_driver *drv)
>>>> +{
>>>> +   const char *drvname =3D XRT_DRVNAME(drv);
>>>> +   int rc =3D 0;
>>>> +
>>>> +   /* Initialize dev_t for char dev node. */
>>>> +   if (drv->file_ops.xsf_ops.open) {
>>>> +           rc =3D alloc_chrdev_region(&drv->file_ops.xsf_dev_t, 0,
>>>> +                                    XRT_MAX_DEVICE_NODES, drvname);
>>>> +           if (rc) {
>>>> +                   pr_err("failed to alloc dev minor for %s:
>>>> %d\n", drvname, rc);
>>>> +                   return rc;
>>>> +           }
>>>> +   } else {
>>>> +           drv->file_ops.xsf_dev_t =3D (dev_t)-1;
>>>> +   }
>>>> +
>>>> +   drv->driver.owner =3D THIS_MODULE;
>>>> +   drv->driver.bus =3D &xrt_bus_type;
>>>> +
>>>> +   rc =3D driver_register(&drv->driver);
>>>> +   if (rc) {
>>>> +           pr_err("register %s xrt driver failed\n", drvname);
>>>> +           if (drv->file_ops.xsf_dev_t !=3D (dev_t)-1) {
>>>> + unregister_chrdev_region(drv->file_ops.xsf_dev_t,
>>>> + XRT_MAX_DEVICE_NODES);
>>>> +           }
>>>> +           return rc;
>>>> +   }
>>>> +
>>>> +   pr_info("%s registered successfully\n", drvname);
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(xrt_register_driver);
>>>> +
>>>> +void xrt_unregister_driver(struct xrt_driver *drv)
>>>> +{
>>>> +   driver_unregister(&drv->driver);
>>>> +
>>>> +   if (drv->file_ops.xsf_dev_t !=3D (dev_t)-1)
>>>> + unregister_chrdev_region(drv->file_ops.xsf_dev_t,
>>>> XRT_MAX_DEVICE_NODES);
>>> ok
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(xrt_unregister_driver);
>>>> +
>>>> +static int __find_driver(struct device_driver *drv, void *_data)
>>>> +{
>>>> +   struct xrt_driver *xdrv =3D to_xrt_drv(drv);
>>>> +   struct xrt_find_drv_data *data =3D _data;
>>>> +
>>>> +   if (xdrv->subdev_id =3D=3D data->id) {
>>>> +           data->xdrv =3D xdrv;
>>>> +           return 1;
>>>> +   }
>>>> +
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +const char *xrt_drv_name(enum xrt_subdev_id id)
>>>> +{
>>>> +   struct xrt_find_drv_data data =3D { 0 };
>>>> +
>>>> +   data.id =3D id;
>>>> +   bus_for_each_drv(&xrt_bus_type, NULL, &data, __find_driver);
>>>> +
>>>> +   if (data.xdrv)
>>>> +           return XRT_DRVNAME(data.xdrv);
>>>> +
>>>> +   return NULL;
>>>> +}
>>>> +
>>>> +static int xrt_drv_get_instance(enum xrt_subdev_id id)
>>>> +{
>>>> +   int ret;
>>>> +
>>>> +   ret =3D ida_alloc_range(&xrt_device_ida, xrt_instance_to_id(id, 0)=
,
>>>> +                         xrt_instance_to_id(id,
>>>> XRT_MAX_DEVICE_NODES),
>>>> +                         GFP_KERNEL);
>>>> +   if (ret < 0)
>>>> +           return ret;
>>>> +
>>>> +   return xrt_id_to_instance((u32)ret);
>>>> +}
>>>> +
>>>> +static void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
>>>> +{
>>>> +   ida_free(&xrt_device_ida, xrt_instance_to_id(id, instance));
>>>> +}
>>>> +
>>>> +struct xrt_dev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id
>>>> id)
>>>> +{
>>>> +   struct xrt_find_drv_data data =3D { 0 };
>>>> +
>>>> +   data.id =3D id;
>>>> +   bus_for_each_drv(&xrt_bus_type, NULL, &data, __find_driver);
>>>> +
>>>> +   if (data.xdrv)
>>>> +           return data.xdrv->endpoints;
>>>> +
>>>> +   return NULL;
>>>> +}
>>>> +
>>>> +static void xrt_device_release(struct device *dev)
>>>> +{
>>>> +   struct xrt_device *xdev =3D container_of(dev, struct xrt_device,
>>>> dev);
>>>> +
>>>> +   kfree(xdev);
>>>> +}
>>>> +
>>>> +void xrt_device_unregister(struct xrt_device *xdev)
>>>> +{
>>>> +   if (xdev->state =3D=3D XRT_DEVICE_STATE_ADDED)
>>>> +           device_del(&xdev->dev);
>>>> +
>>>> +   vfree(xdev->sdev_data);
>>> cleanup of sdev_data here
>>>
>>> fail: label in xrt_device_register is ok.
>>>
>>>> +   kfree(xdev->resource);
>>>> +
>>>> +   if (xdev->instance !=3D XRT_INVALID_DEVICE_INST)
>>>> +           xrt_drv_put_instance(xdev->subdev_id, xdev->instance);
>>>> +
>>>> +   if (xdev->dev.release =3D=3D xrt_device_release)
>>>> +           put_device(&xdev->dev);
>>>> +}
>>>> +
>>>> +struct xrt_device *
>>>> +xrt_device_register(struct device *parent, u32 id,
>>>> +               struct resource *res, u32 res_num,
>>>> +               void *pdata, size_t data_sz)
>>>> +{
>>>> +   struct xrt_device *xdev =3D NULL;
>>>> +   int ret;
>>>> +
>>>> +   xdev =3D kzalloc(sizeof(*xdev), GFP_KERNEL);
>>>> +   if (!xdev)
>>>> +           return xdev;
>>> ok
>>>> +   xdev->instance =3D XRT_INVALID_DEVICE_INST;
>>>> +
>>>> +   /* Obtain dev instance number. */
>>>> +   ret =3D xrt_drv_get_instance(id);
>>>> +   if (ret < 0) {
>>>> +           dev_err(parent, "failed get instance, ret %d", ret);
>>>> +           goto fail;
>>>> +   }
>>>> +
>>>> +   xdev->instance =3D ret;
>>>> +   xdev->name =3D xrt_drv_name(id);
>>>> +   xdev->subdev_id =3D id;
>>>> +   device_initialize(&xdev->dev);
>>>> +   xdev->dev.release =3D xrt_device_release;
>>>> +   xdev->dev.parent =3D parent;
>>>> +
>>>> +   xdev->dev.bus =3D &xrt_bus_type;
>>>> +   dev_set_name(&xdev->dev, "%s.%d", xdev->name, xdev->instance);
>>>> +
>>>> +   xdev->num_resources =3D res_num;
>>>> +   xdev->resource =3D kmemdup(res, sizeof(*res) * res_num, GFP_KERNEL=
);
>>>> +   if (!xdev->resource)
>>>> +           goto fail;
>>>> +
>>>> +   xdev->sdev_data =3D vzalloc(data_sz);
>>>> +   if (!xdev->sdev_data)
>>>> +           goto fail;
>>>> +
>>>> +   memcpy(xdev->sdev_data, pdata, data_sz);
>>>> +
>>>> +   ret =3D device_add(&xdev->dev);
>>>> +   if (ret) {
>>>> +           dev_err(parent, "failed add device, ret %d", ret);
>>>> +           goto fail;
>>>> +   }
>>>> +   xdev->state =3D XRT_DEVICE_STATE_ADDED;
>>>> +
>>>> +   return xdev;
>>>> +
>>>> +fail:
>>>> +   xrt_device_unregister(xdev);
>>>> +   kfree(xdev);
>>>> +
>>>> +   return NULL;
>>>> +}
>>>> +
>>>> +struct resource *xrt_get_resource(struct xrt_device *xdev, u32
>>>> type, u32 num)
>>>> +{
>>>> +   u32 i;
>>>> +
>>>> +   for (i =3D 0; i < xdev->num_resources; i++) {
>>>> +           struct resource *r =3D &xdev->resource[i];
>>>> +
>>>> +           if (type =3D=3D resource_type(r) && num-- =3D=3D 0)
>>>> +                   return r;
>>>> +   }
>>>> +   return NULL;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Leaf driver's module init/fini callbacks. This is not a open
>>>> infrastructure for dynamic
>>>> + * plugging in drivers. All drivers should be statically added.
>>>> + */
>>>> +static void (*leaf_init_fini_cbs[])(bool) =3D {
>>>> +   group_leaf_init_fini,
>>>> +   axigate_leaf_init_fini,
>>>> +   icap_leaf_init_fini,
>>>> +};
>>>> +
>>>> +static __init int xrt_lib_init(void)
>>>> +{
>>>> +   int ret;
>>>> +   int i;
>>>> +
>>>> +   ret =3D bus_register(&xrt_bus_type);
>>>> +   if (ret)
>>>> +           return ret;
>>>> +
>>>> +   xrt_class =3D class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
>>>> +   if (IS_ERR(xrt_class)) {
>>>> +           bus_unregister(&xrt_bus_type);
>>>> +           return PTR_ERR(xrt_class);
>>>> +   }
>>>> +
>>>> +   for (i =3D 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>>>> +           leaf_init_fini_cbs[i](true);
>>>> +   return 0;
>>>> +}
>>>> +
>>>> +static __exit void xrt_lib_fini(void)
>>>> +{
>>>> +   int i;
>>>> +
>>>> +   for (i =3D 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>>>> +           leaf_init_fini_cbs[i](false);
>>>> +
>>>> +   class_destroy(xrt_class);
>>>> +   bus_unregister(&xrt_bus_type);
>>>> +}
>>>> +
>>>> +module_init(xrt_lib_init);
>>>> +module_exit(xrt_lib_fini);
>>>> +
>>>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>>>> +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/fpga/xrt/lib/lib-drv.h
>>>> b/drivers/fpga/xrt/lib/lib-drv.h
>>>> new file mode 100644
>>>> index 000000000000..0276c28e009f
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/lib/lib-drv.h
>>>> @@ -0,0 +1,21 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + * Cheng Zhen <maxz@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _LIB_DRV_H_
>>>> +#define _LIB_DRV_H_
>>>> +
>>>> +#include <linux/device/class.h>
>>>> +#include <linux/device/bus.h>
>>>> +
>>>> +extern struct class *xrt_class;
>>>> +extern struct bus_type xrt_bus_type;
>>>> +
>>>> +const char *xrt_drv_name(enum xrt_subdev_id id);
>>>> +struct xrt_dev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id
>>>> id);
>>>> +
>>>> +#endif     /* _LIB_DRV_H_ */
>

