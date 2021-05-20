Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D90389B80
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 04:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhETCtl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 May 2021 22:49:41 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:42592
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhETCtk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 May 2021 22:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEWtE2dUY58vLxrh7/4c2bqK7S9hATqMidajHdm270DIo04zeLex83AqdQqyyjC2TTAuvVvSMKygCUP8cTJkWF/f4SOgauUD1EmNUiA2dFNWCBV571mujSwUOUs0lO90UgGT02LD7eH/wWbRNXpzW1mNiPs/0O9qutICAIS/Lg2zU7bEp4ZE1I7BThDP/yp1CCoiBNt0rqJRpwKqOb/nx5Db+Kup/Y9qBLAHK5EIHS31fvy2DPGQqIZB7BPIX+7Uu1QRgemCmKKqT4SVNGoLzGE9XtIJH/WRR1LxTOohT4Z2129/UGUiZZTsHGgT7SLik7jPeefj3Frl189B1647Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GILSUQ/1Ltt9d+xp6GpgI9F0p2v1XNem3IOKvoztI50=;
 b=Hif9YiMvixbiq+rRybyIakwKYed8dlcQv6JrqSe6IjIJVWH2S4xOXM261ZGGLXfnsNOuq6xF058msCfm8EshqhTIEOD5C57W0EGUleTk9xBLqBIn0qtylckEFRCyqG2HvGhuqkofWoNRi3cV8uGUSzUrHucOrNKwTKu5B/GhZxQis6vM3Um8/pM1u0zuTjzvv04Xxac7I1of8s1e3C1lyo2cUP7OFdZF2Xmlh4g1aMySo52Kti98KdVd9vLSremALy7WTdhHAxiPvTYjAjMxzNyOgjSeG+X3IZH+MTuJOx9jZ0v2jQ538qLt+bZ8dXTatJtxyW5i5sBLFdSBnv4X4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GILSUQ/1Ltt9d+xp6GpgI9F0p2v1XNem3IOKvoztI50=;
 b=MMDCF/AIK/Utsws+/rWe6xh2SclTxhafgqEDhRZpjTmyB4lsf7lUkeS5mMjPHdvRpKyzc8zL9e3/OPOF/qzLLpQhqKX0WNla9cJ9wGwH4vFsVBJu72b4tY/OQ0GDHOrWGjiPmyAdfRBdIqKJClINnDQ63NAJTAkPudJmvYhen+o=
Received: from BN6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:404:10a::13)
 by PH0PR02MB7255.namprd02.prod.outlook.com (2603:10b6:510:16::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 02:48:18 +0000
Received: from BN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::94) by BN6PR13CA0003.outlook.office365.com
 (2603:10b6:404:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Thu, 20 May 2021 02:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT037.mail.protection.outlook.com (10.13.2.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 02:48:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 19:48:17 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 19:48:17 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=56828)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1ljYjR-0000yZ-H1; Wed, 19 May 2021 19:48:17 -0700
Subject: Re: [PATCH V6 XRT Alveo 08/20] fpga: xrt: driver infrastructure
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
 <20210512015339.5649-9-lizhi.hou@xilinx.com>
 <c6ed9349-1a9a-62a9-521f-a12ec8c4a5a5@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <f0dfe5ee-d4ac-895f-1ba6-136cd897ba08@xilinx.com>
Date:   Wed, 19 May 2021 19:48:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <c6ed9349-1a9a-62a9-521f-a12ec8c4a5a5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e98fd6da-b0d7-4b1e-4087-08d91b39b93c
X-MS-TrafficTypeDiagnostic: PH0PR02MB7255:
X-Microsoft-Antispam-PRVS: <PH0PR02MB72558E6E39A3EEBFC51B9B58A12A9@PH0PR02MB7255.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRylPmlKpnhM+P23DqKKWPxulN5Kj9YJavPk1Tcy7C++hXXGvJQpUI8wmFu2N4Nl/gmXbxU1C6se+ZNUqzJMYxU+qDEXrBjT1pcFZHGdGMWqnIA44lI3fxMpPc8LuzFHZl/2OBm0c6QfUTk/JC3xUbMJBYJ/VMHYvk2qLYUc+c6RAH+QHI2c1Xkwv7Jj9jpBpECq1bcG6GP3cRJG/HQ3isgp3qynIToT1zr9cM0tL/5l/GdZ6G2FcLq0ukediDkkXtoABI0SKAtp+fdti1IHElv9qB8Ez5Anzterb26LEtaYG3oHgfUdtgs2v2kMxrm8Qk12nPr7dPjEijLuFcbO3buXuGv26IePxQ2+6UBbRhBlheSI4XSnsqC93LipdRo+gdSxXrS/+aEbb96WP2OgQM6RZk+inR7ACtGmzF3v7wNhPp6EMQ4uBoWSu4EZTm3gXnqf1kMZ0GJKeoEtLhK8L0Sz4QqH/Z4ppZkpyQBKJrR2v7bLFh4SYmRUpD+0zcNgjsdEjAPo4w2cugTvqI0n6U33aADiYkanvcPF666dXaCT/KyGmTioN5iQwcBRqoEhiWJeVCHLTTWyVX7SK9X0Zxe1ObavlkwZfFhgG9CwnpJNWNNgDH+Pd5+/DlYyiFD/J2Dvzi5KweGZ8OCrweN9d3xIcfuJ807fQ/stkkRU9XPkE6T1ENiuzUwLL0lQVPkN/jqo5BEzEfyZfo9goqn1XSBu1os7JC1OQ8gNYGwdfhY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(53546011)(36906005)(2906002)(110136005)(54906003)(31686004)(44832011)(336012)(2616005)(426003)(316002)(5660300002)(47076005)(36756003)(478600001)(26005)(82740400003)(356005)(31696002)(186003)(8936002)(70586007)(70206006)(9786002)(4326008)(107886003)(83380400001)(7636003)(36860700001)(8676002)(82310400003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 02:48:18.2985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98fd6da-b0d7-4b1e-4087-08d91b39b93c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7255
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 05/13/2021 08:27 AM, Tom Rix wrote:
>
> On 5/11/21 6:53 PM, Lizhi Hou wrote:
>> Infrastructure code providing APIs for managing leaf driver instance
>> groups, facilitating inter-leaf driver calls and root calls.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>
>> +
>> +int xrt_subdev_root_request(struct xrt_device *self, u32 cmd, void 
>> *arg)
>> +{
>> +     struct device *dev = DEV(self);
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
>> +
>> +     WARN_ON(!pdata->xsp_root_cb);
>> +     return (*pdata->xsp_root_cb)(dev->parent, 
>> pdata->xsp_root_cb_arg, cmd, arg);
>
> I am running v6 through clang's static analyzer.
>
> It reports this problem
>
> drivers/fpga/xrt/lib/subdev.c:72:9: warning: Called function pointer is
> null (null dereference)
>         return (*pdata->xsp_root_cb)(dev->parent,
> pdata->xsp_root_cb_arg, cmd, arg);
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Though there is a warn_on, can you also add a
>
> return -EINVAL;
>
> To cover this case?
Sure. I will run through clang myself to check the fix.

Thanks,
Lizhi
>
> Tom
>
>> +}
>

