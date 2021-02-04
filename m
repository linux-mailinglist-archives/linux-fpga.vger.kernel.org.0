Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6683030F3A7
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 14:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhBDNGj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Feb 2021 08:06:39 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:20803
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236234AbhBDNGi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Feb 2021 08:06:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFG8iQoKXRHUjxq9vxhErFUZokWiBAuCGYPEdOs9NKwR1DGz9zoTDbDBFWKpIls28COfa28CZuwAMqHeVgdYYvnnoEjIeIYLkAdpCY+XVfykeo6X9XiyY0kHjOIAsRFsP+bt5Cl0WU/KVMo7ycQe8XwDVguWw3/suQDgfkgaN01b4GxroVh06tsPKiCm7FaIq+uTQlcuaN0oJjlx5VnRyZvh/e9wXVXteWho2OBm9K59l/D/GF0HUeZqabTvcGoXplB6BS2bX/CDBAhv7bX32HLOP2mFYpmmQxEZcVh4qsb973SGeQfwWGgyE6gxEKjJK4jHKqwpaaa3kcvsL8xrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGdJqWF+7YrMbxT/p68FbPsgOjvPPJj8PcQ2+4SWssI=;
 b=Yb8EtoFAMOBLLkNWKcz1wOmcZRAxk94amG96yGUxrrqB0ueWZH9lwXZVTD1A4M/tqn5sLXdsFZ6x7eOu+/AthXT6HMV7fvj8VRQ7wHv7QkWJtROktxkxENxzYo3yLy3/Tvb3xau2qLfVu43eRJmJhuK3lrRcwM1F75o327TK1X+tDB9WbwsK+zHqG8PMaGMYK6gjabMmJrVSdjSbxeXoc91D9ezBOiXMDp7ROoI08fC6lATIvdJIwQROeNeBsJwme3JIgPyTxzyrhVGMzGTG7yPkqN/PKw7Wm+viwz0TzUr0u7oMwmhry/AQE3jMlqPu7fgKqmLEQdcvBHJZDNw3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGdJqWF+7YrMbxT/p68FbPsgOjvPPJj8PcQ2+4SWssI=;
 b=hs3mdzpJKjgI4yzy4ZqBrMswof1KgLMm+pxM9HppM0/yADbpEQo+j2aVwDDaC9QjiYdFfY5nu2ZeXG3gxMzKrMwSpxL77vrytQjnJiKSqwpvGvNjkGpsed5zrZ+pEe69Gp1UIMuAq/m4yyiEILm5gdCcVxJSfrgHQrqA97h/Dzw=
Received: from MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22)
 by CO6PR02MB7508.namprd02.prod.outlook.com (2603:10b6:303:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 13:05:45 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::f0) by MN2PR10CA0009.outlook.office365.com
 (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Thu, 4 Feb 2021 13:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 4 Feb 2021 13:05:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 4 Feb 2021 05:05:40 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 4 Feb 2021 05:05:40 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 agust@denx.de,
 atull@kernel.org,
 trix@redhat.com,
 mdf@kernel.org,
 linux-fpga@vger.kernel.org,
 luca@lucaceresoli.net
Received: from [172.30.17.109] (port=59400)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l7eKJ-0005X1-TQ; Thu, 04 Feb 2021 05:05:40 -0800
Subject: Re: [PATCH] fpga: fpga-mgr: xilinx-spi: fix error messages on
 -EPROBE_DEFER
To:     Luca Ceresoli <luca@lucaceresoli.net>, <linux-fpga@vger.kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Alan Tull <atull@kernel.org>,
        Anatolij Gustschin <agust@denx.de>,
        <linux-kernel@vger.kernel.org>
References: <20210204121313.24655-1-luca@lucaceresoli.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <42040ab3-d486-ecf4-ce22-bc4c992f3151@xilinx.com>
Date:   Thu, 4 Feb 2021 14:05:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204121313.24655-1-luca@lucaceresoli.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c4e553-7281-4b10-f335-08d8c90d9578
X-MS-TrafficTypeDiagnostic: CO6PR02MB7508:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7508018A379F1F5D37A2530DC6B39@CO6PR02MB7508.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEWMPpB1EqK0OPyeSNfyZ8D39lObz7kpUYz2ddFd9pNA8HKwk3w66WV7zEj2LwVuJNrz5ZPD6/gwcgx+gvPnlYYv56d8YAwGvxbFrQeOxtfE8xO+i7IXoFneVTXsJjbQdDpCVF1wnU9RvwIYRjz1xJEuyKVIGt1v5vPRh3YLFnAPLaMaABjqKESYFKmPqMww118cdeBdgAOqqDoh06FE1TvN64VPQYTArFOoGFpKZcjb6FISIj07Bki2jT/WVqfacNacKJhnvHXo+5L9OlqLfcnlR3pG9EraW58sEflsQPTU3AA2L1XMtx1H7JZiNzt+08Qd7JsEKNG/oju0AkpmfnSvGLm1GA37PmCstYBv/ZuKy3qBVtnNatNVRAWgJ0NI4MfNuYF5MBhQNFy+ozjCH5pbn9wxK3YCLvWsxYxmUeqHDqWUzAsVS5ljOw9+8H8hA8OgIZPqlQVVZBSw9G4jLn+HhdkY5uR+HklFX3zLdWOpNzYLfc2ScLO1OGbJEwIBXzaYXiAV6keiBJ7itFIwRLzigiViagdFQetvwhFlxytOlYyowtGhoKPioDmOnGWAjxd//Stsy+QeZeqZchNXIQ0W/ikekKay3d+H+jfnQ89v1aP0fOFwHNV3VS7b2gWBsXPkhN4sh2xE3i21Z8+s/L2k/tBEg0A73NGgdDo2sQ2bhCanNyH0B/QFw+6KBtJ44VhJcSfEgH5PNc5psUu892Jx5hPCrHbiudgZ4/Gfz4Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(31686004)(9786002)(36860700001)(8676002)(316002)(54906003)(36756003)(36906005)(110136005)(44832011)(82740400003)(426003)(4326008)(53546011)(82310400003)(8936002)(356005)(70206006)(186003)(2616005)(2906002)(26005)(5660300002)(6666004)(478600001)(31696002)(83380400001)(7636003)(15650500001)(47076005)(336012)(70586007)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 13:05:45.0995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c4e553-7281-4b10-f335-08d8c90d9578
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7508
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On 2/4/21 1:13 PM, Luca Ceresoli wrote:
> The current code produces an error message on devm_gpiod_get() errors even
> when the error is -EPROBE_DEFER, which should be silent.
> 
> This has been observed producing a significant amount of messages like:
> 
>     xlnx-slave-spi spi1.1: Failed to get PROGRAM_B gpio: -517
> 
> Fix and simplify code by using the dev_err_probe() helper function.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
> Fixes: 061c97d13f1a ("fpga manager: Add Xilinx slave serial SPI driver")
> ---
>  drivers/fpga/xilinx-spi.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 27defa98092d..fee4d0abf6bf 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -233,25 +233,19 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  
>  	/* PROGRAM_B is active low */
>  	conf->prog_b = devm_gpiod_get(&spi->dev, "prog_b", GPIOD_OUT_LOW);
> -	if (IS_ERR(conf->prog_b)) {
> -		dev_err(&spi->dev, "Failed to get PROGRAM_B gpio: %ld\n",
> -			PTR_ERR(conf->prog_b));
> -		return PTR_ERR(conf->prog_b);
> -	}
> +	if (IS_ERR(conf->prog_b))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->prog_b),
> +				     "Failed to get PROGRAM_B gpio\n");
>  
>  	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init-b", GPIOD_IN);
> -	if (IS_ERR(conf->init_b)) {
> -		dev_err(&spi->dev, "Failed to get INIT_B gpio: %ld\n",
> -			PTR_ERR(conf->init_b));
> -		return PTR_ERR(conf->init_b);
> -	}
> +	if (IS_ERR(conf->init_b))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->init_b),
> +				     "Failed to get INIT_B gpio\n");
>  
>  	conf->done = devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
> -	if (IS_ERR(conf->done)) {
> -		dev_err(&spi->dev, "Failed to get DONE gpio: %ld\n",
> -			PTR_ERR(conf->done));
> -		return PTR_ERR(conf->done);
> -	}
> +	if (IS_ERR(conf->done))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
> +				     "Failed to get DONE gpio\n");
>  
>  	mgr = devm_fpga_mgr_create(&spi->dev,
>  				   "Xilinx Slave Serial FPGA Manager",
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
