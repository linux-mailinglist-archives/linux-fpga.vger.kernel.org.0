Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B157F30AAE7
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhBAPRY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:17:24 -0500
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:17045
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231587AbhBAPQY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 10:16:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHDabpSyw4ihGPO2DTduKpIAtSJqtz8PQxkxOfX4MnpkXu2KTFhHQFsNua3zTAFL8yJB4325LY8r6+6YYs+kvoyOb6njMR6j8Wx6sjG7cH2ta0CbXyURiv8A5WyD+aPsseD4IKlDVoewgcMYLrDVy22FWg0ObWk539ZmGyints7BfjJ1ZE3x57B406MGTKAc7eg1sQ6a5HJo0A8m5pC6l7o+RewmcYvTsFVbfiROlZ6o97uFIFuf5bZ8DkTtecW98c0NTY8FyzifRVOSwTyshAZDkAl9urYhKApYtJW4mCuCBbVJovlAnS8gs/Z8JB77ZoVOIp5E46MArE1Na0WEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kGKHCOGnFhI+2WwQZwR3PE6UObSwtZynuMV8Z8Nryk=;
 b=S27Bn0bYfY/2UkwuzCpH+dM/IyKIS1NWblLtO3erTXTFO8et7wdeakduaswGtsvRNK55qr+o6197i9vt/owdmw7Kc3zj7/C5UuKZlo3RU88V1eqCztNhy9UHroiRoZqpkWhCwRbXvuVoTFRJQpXo2sCnzVEy92WwMGsQi8BagPr+4qUnOTd6Ntm7aakPKDgBUZLereTRW4aJGSzvHVOJVt/D2BMeKub6FrGTGCY4OZiz2UfUCiD2RYZ/8LVxz41jl8Y6WtZfBfc9lz7/UeyMDqyMmVtUZ75gyDvH0mxqKrAGQyPOh46N9ctn/GX80cw0mb7XZx0wDKas6hFps3nHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=analog.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kGKHCOGnFhI+2WwQZwR3PE6UObSwtZynuMV8Z8Nryk=;
 b=HIxQi91ebPnFDivO0n2N7wZFyF7pTF/IGUTfEr4a7eB0mCZce7V0i5JG9ugojMC+6IF17m/BGVpRcQ4yOoV/W0NHZ7RO/I5cmexzvfhixOVDxKqB+DdUy/XkF6reqBfcLFtdhXMMLXtqvfp/YLVrnZTOTP0t42Y/aGtpNjliuZg=
Received: from SN4PR0701CA0035.namprd07.prod.outlook.com
 (2603:10b6:803:2d::25) by BYAPR02MB5880.namprd02.prod.outlook.com
 (2603:10b6:a03:11d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 1 Feb
 2021 15:15:30 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::a5) by SN4PR0701CA0035.outlook.office365.com
 (2603:10b6:803:2d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Mon, 1 Feb 2021 15:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 1 Feb 2021 15:15:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 1 Feb 2021 07:15:29 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 1 Feb 2021 07:15:29 -0800
Envelope-to: dragos.bogdan@analog.com,
 ardeleanalex@gmail.com,
 mdf@kernel.org,
 linux-fpga@vger.kernel.org,
 lars@metafoo.de,
 robh+dt@kernel.org,
 sboyd@kernel.org,
 mturquette@baylibre.com,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org,
 alexandru.ardelean@analog.com
Received: from [172.30.17.109] (port=37420)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l6avJ-000343-Kl; Mon, 01 Feb 2021 07:15:29 -0800
Subject: Re: [PATCH v3 1/4] clk: axi-clkgen: replace ARCH dependencies with
 driver deps
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, Dragos Bogdan <dragos.bogdan@analog.com>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com>
 <20210201151245.21845-2-alexandru.ardelean@analog.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <3be0501f-98bf-8371-6994-e77c94b4597b@xilinx.com>
Date:   Mon, 1 Feb 2021 16:15:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201151245.21845-2-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e75972-71a6-47ba-738f-08d8c6c43692
X-MS-TrafficTypeDiagnostic: BYAPR02MB5880:
X-Microsoft-Antispam-PRVS: <BYAPR02MB588022DA41E628739E58FA90C6B69@BYAPR02MB5880.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLE1kjyI63P4DQlBIFE9shsbh7HNqL/cTcKc08UCcu5nY6F6yaWRxWu+ESh7AT0BjtenSl4ZQb52/LsqQnzUvy6+b+cwa46Fd+56vUP1Jl+Y5TmnCCgUq1QJh5kmjEflipGkFaT3+5r2lz5rEeIkExxRybt6WlIfTfYydwV/BtSvWrJc6HI/LnvT51p6MEvWbS7NfIGMquvdsYgTI/EZTljDVo0dR+3V0gQ1LSFvpoI+JU5Gk7pfth8EdCQWObPFhXXE/YJSJpVm2QVhvTwA8CsgndEhCNG/ZrpKPSCtVd9L1wnoKDtPLtUKxWJTkjHfAhsJ6mas6O9Q7lMb720FUNKcJYdgFp94MhbD0ctq9JfFiA4SQnpSV1q7HInrOTM+26or2yMGfnj0cFjko33WwD5OuMjuHWDKyVF1B5O4nvLvYldckcK2aECnKej0IIIyxujW+0/fvgr3fqK+3pknvcL2Xma+t27MTZhgCJ99oX2Z7264LjDvUnIfgcCzA+AG73XyQGs9WURh9GNhyCQOndyv2NQ2fqiF/CSNKl4gMkWN4NLQLGNadjyypvo5zV3NaTX4U/XiM9QA+f0IGt1+UnS8wDbTHtMlfsC1iB/U943H10fU0tVq+mWRfyXb372lOG+lm0CiYJSB6ufPzbCoDg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(7636003)(7416002)(54906003)(31686004)(186003)(6666004)(4326008)(82310400003)(70206006)(9786002)(47076005)(36756003)(356005)(336012)(2616005)(82740400003)(70586007)(110136005)(426003)(8936002)(36906005)(5660300002)(316002)(53546011)(31696002)(26005)(83380400001)(478600001)(2906002)(8676002)(44832011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:15:30.3582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e75972-71a6-47ba-738f-08d8c6c43692
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5880
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/1/21 4:12 PM, Alexandru Ardelean wrote:
> The intent is to be able to run this driver to access the IP core in setups
> where FPGA board is also connected via a PCIe bus. In such cases the number
> of combinations explodes, where the host system can be an x86 with Xilinx
> Zynq/ZynqMP/Microblaze board connected via PCIe.
> Or even a ZynqMP board with a ZynqMP/Zynq/Microblaze connected via PCIe.
> 
> To accommodate for these cases, this change removes the limitation for this
> driver to be compilable only on Zynq/Microblaze architectures.
> And adds dependencies on the mechanisms required by the driver to work (OF
> and HAS_IOMEM).
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/clk/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 85856cff506c..cee1d4e657bc 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -247,7 +247,8 @@ config CLK_TWL6040
>  
>  config COMMON_CLK_AXI_CLKGEN
>  	tristate "AXI clkgen driver"
> -	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
> +	depends on HAS_IOMEM || COMPILE_TEST
> +	depends on OF
>  	help
>  	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
>  	  FPGAs. It is commonly used in Analog Devices' reference designs.
> 

Make sense.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
