Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A241A2D6
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 00:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhI0WXh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Sep 2021 18:23:37 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:41313
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237444AbhI0WXh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 Sep 2021 18:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+Mt2yu9Lgd5YyPGjFE1gFQSaeNm4N81wgiby9l5jiMPaEL8QZ1fVWJX/tAC8YMj6oZyZrg0IFqRLe7gMrzX8yrkdk+c1vmLFL6yJ/DL0w2Emf9cEpo2s8CGAfYDS0cbXF9rGtfBgmET2be0jVBxRB+br+gIrtzuzOiBPi0WzhT67n6iOAK3eB44phTrIOB8orlTDf0XRXRnpgj/Bml31reaCmq5VFMbkgekDm+Bx7+gbTNn3deLSFfzmtQ2jj1qOONTHHwIiiw4p8i0pUdsK7082hgegfnKkDlXwboObMSDlWBIKf46a1LKNlMjGUZ28umdqPvxpjv6C2D/5yiK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HlX/XYyhCSAaGVzXELZPOcwV2cpqySAL8rvcFp+htXs=;
 b=CNbnqB2W9ptSS3GbTzcga9Ro1TnKLTQRtMgk+Rb3kyaQsqa3vkR2JOxdPkmIEb07Mtvjo1ByYapmhCRTAkPimA2rEn5Srdn4UXJhmnIrrjIV8YJTbd7fJi/ntxOhMkuxItUlr+lQW93o/yM6DLXFa214rXP+y6tzSiTCs1ZdIj98wlDrT3V+tCloCnT5SLcK0ph6+C4uuqLXflkY9wtyqG8LxeAZrB0vS5K7Bb+UuEC52b3emFbClQiHCUZ3UgkSO3i7vFxD7fvACE+aDdo+IcAYjzfQaH1s7F1Gkh2bBchUhanckfcSAwH/nbN/19q5uKWdRRkq3D9x7H3LvVyIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlX/XYyhCSAaGVzXELZPOcwV2cpqySAL8rvcFp+htXs=;
 b=rvM//D4NTbwJnUqivV/fFiz1IwsJBJcYEvjShMQ995H45DglEY/jYb5/RhCfCUb11oZGhfVBtdgmrl4ewZCSNXdg+ik3WoH2cb9pQZqh0tRS9vbG//EbguGpCpg9QcSq1Q1PcKUUdzI8pCrSqw2O7yM7uNyEeO7/Pg7ro/hCuKw=
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com (2603:10b6:a03:3d9::15)
 by SJ0PR02MB7789.namprd02.prod.outlook.com (2603:10b6:a03:322::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 22:21:55 +0000
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::ac20:2659:251c:ca97]) by SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::ac20:2659:251c:ca97%7]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 22:21:55 +0000
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
Thread-Index: AQHXh7hkMnlVlDFjJ02raPeREcOtWat62AIAgANwSICAH79ygIAFwVwAgBTZnMg=
Date:   Mon, 27 Sep 2021 22:21:54 +0000
Message-ID: <SJ0PR02MB88453F1A2ADEE327C5BBA203BBA79@SJ0PR02MB8845.namprd02.prod.outlook.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
 <20210802160521.331031-5-lizhi.hou@xilinx.com>
 <9a214e25-65b3-586d-13b6-e37a380dc10e@redhat.com> <YSEthfOlsQ+7JGMN@archbook>
 <b0918d69-bb7a-0e2c-95f2-99714eec545a@xilinx.com>
 <14eb61e8-2a97-5d6a-7bbc-51aac882f3d9@redhat.com>
In-Reply-To: <14eb61e8-2a97-5d6a-7bbc-51aac882f3d9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: c841c9c1-47e7-d1a1-de7d-784cf5fdcd63
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d95b8ac-86a9-4819-db5e-08d9820536a2
x-ms-traffictypediagnostic: SJ0PR02MB7789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB7789B27F49BE62C37AD3D6B5BBA79@SJ0PR02MB7789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: he2+Y/4ZUGzNETwlgVdKOMVpf4nd1O+I51hxMX6R3PLlMNPRC3mozRclfkAiZoN8QuxD7nONblBzyNKXC4OwtNeDB7rI6Ls8kN3ushR8DW303/8Arle2Cbj+Cug/7a3OeCX+NtafGVIviGvvifSgwCj/SrkKHmB9appn2WmQ8vbcrSTqePjGuj2DFSMhgNWzGTK3pdzHbVW3Uph8KJnrOx3+Vt9DD8Ag6SjroBxoOOxGlx0sCp8AJpO7VDl48URfjPKTFlT88+aa7AfxuP38B4xD27NzoFZ+rIOAr3NZXSIk5otXk0sXaytSmZgpkLsq3pE3Wx1bg0kXWmrRB9bp8LVfOZ8wfvLoG1FFDPdgybpq018t3+BJO5+Ym8/ER4d+Bie/GDuLWrt2DcRdOilJtnfz2hahEwA4BeL53pVwbiEP1Ncs01SpVHxe8/GrRgSmc9Z9WOWHADWVXU7/vms1Bkwtsjjorhb6wKlK0TAxPsopT4Iw5akmDq97kejYJn9wRMUbrxUSiTZpHfqbt0R7gMPvyGewW/O5yWUs+WOmLEU8/7QXFqbx0BxF0/5uIRIVKHNoC6kT3AYgPjZVfTm/3eoMeyQl5pjFXdOvJewGh1Co4DR01WyuHD7QhJO4hos5sMypXFWs3qBP2/TG6HTh8WmiaZsq1wQLWQLKhnEf4S6pjzW+5JarffKk7wdYtZnwsD3BkPNAFT1PMSN5Uw3mxgnbEhhf7zF1KhQG6ZtjW9Ej2F+Se7AmY0SlPnks+S+MA0xOo0ofz41wCksFDllWNYNwj39WqNSzQAm4SNUlnqYoflEqytyxjYYPxX9BI1b0g7zsumB4mVukCtpvrJec1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8845.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6506007)(9686003)(86362001)(26005)(8676002)(5660300002)(33656002)(76116006)(53546011)(71200400001)(66556008)(55016002)(64756008)(66446008)(66476007)(8936002)(83380400001)(38100700002)(4326008)(54906003)(110136005)(2906002)(38070700005)(30864003)(122000001)(966005)(7696005)(52536014)(508600001)(316002)(186003)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Cu5UbsLE1lEuvoFkZqtifIvjP4+gjkZaxzYwHOvzhN5tp14v7/5j4sE4qD?=
 =?iso-8859-1?Q?sx6l85JUvsqmiqwovkedLjKbyxHmPQZWHFCi6/UTYXmyZVni8WeaYXT2U5?=
 =?iso-8859-1?Q?Fe+Oil8/SlNbbWFJDqw2tcECEbQ4151kfUlQYuJUGJdGCrcsbquZn467ek?=
 =?iso-8859-1?Q?rVaJvjTmL/HwSEtqs4L/vkgYiBV7VjEw1HRtfnUFcu1OPEEsFNKPsWxMCG?=
 =?iso-8859-1?Q?it2sJ+7Y3yAmEjD39uqrD8j/zrsrkR9Z4VO5XGGXqyZ+ntbwtrYToJ9kLw?=
 =?iso-8859-1?Q?UuYRgkE5PHO0ijWCjvXTTpclKcbtjOFBsY72+22L3x9M9cZzdxvovrwB+F?=
 =?iso-8859-1?Q?f74umSsY6it/YlMrzZ3AW9jZ2xJbdEoD1tbuFhOWPEwy49Bu3dhho2n8ef?=
 =?iso-8859-1?Q?bT6UsHwd14P9/jz53nf2ZhAjVNGcezKIRck+SdahQ+cDwVIfhV1Y/MrOM4?=
 =?iso-8859-1?Q?5cZ4ALi7G6Xjl3m+O3xakgKiojk8cn5XkJe78CaCzHWFzXg6JL/sK0nDhk?=
 =?iso-8859-1?Q?B1LtRGgR5vJoztR3TTDNgKhLsn1e80ucA7lktRN26p1O/X8LcjbLOinNZ0?=
 =?iso-8859-1?Q?2hTGluKeIFswnqC3rCWznL74eqUJFDIjim44RKJx4eGKMCseg0jtQFQXKy?=
 =?iso-8859-1?Q?IX3B3z+XQxgr/ZMw5FLniHGZ6xvzaQs/nY5+a2LpAyoM+4NX8nlandVGrJ?=
 =?iso-8859-1?Q?OmntAaJlXjMeB++68NGD74uQZqCYO29V5B9nEj8V/VHWsLlb8TPS9iIfpB?=
 =?iso-8859-1?Q?m/c+j0+CJGBa/uWMf7jJPHVxg+q/pVfuj7GY2T5TIuHYH0JkSijuVlVzOd?=
 =?iso-8859-1?Q?V+PYqUjqfq+TlJHqYgnNA6PTiHpyOkFxMVlDpl3kN6PSQ3UTbWuhnO3eWl?=
 =?iso-8859-1?Q?iDGetn+HJmDrJnfj+vu0WNjh0FCwQjX4Gvkh5ePn3RnjvID0CYySEwGL8s?=
 =?iso-8859-1?Q?cJNnB7Uw04VXdYA8Gxa4IPq89rrIUp42dTk84GR2rVUEj9IC8pjSzrBlDs?=
 =?iso-8859-1?Q?3amQJt0HfSmDq4S1R7SlnV9ErVWaDOcfItMLy29mVAqY6Gv0yhrt09QvMz?=
 =?iso-8859-1?Q?YG1oT4XlTfA3uC383WyVBLVTAvfyyCo2U1z7uVVgkaMfjk/jz2GeC+/8zd?=
 =?iso-8859-1?Q?V5NnERJgNY51J666awAJ0aJ6hTIHPFDNGg3TrG4BMTI0VYifuUkvNvVMza?=
 =?iso-8859-1?Q?V1uLNqkMorh0DSipDL1Mgypp25VIiamp58fB1RZGUPGuB3lvUsSi6bsxmH?=
 =?iso-8859-1?Q?WvJ9p4GhJJlsmT8d59tXrgJQyz/iTbKKTVTUodG4nDvnQRaLo5L5CrQDxX?=
 =?iso-8859-1?Q?AssusdogOAPbvic4BaPMPUZ4BNivjAvErSVGBS3OjFrEijkV2LHlmt9wj3?=
 =?iso-8859-1?Q?PQqQp82wzQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8845.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d95b8ac-86a9-4819-db5e-08d9820536a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 22:21:54.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOdh8pnLAN67edpNR8SesgHUryLq0MfDizJNVCJaE/B3I6OdHoemjvbVsmdsW1lvfs1fulawR9ubDy++qL2PQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7789
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

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

