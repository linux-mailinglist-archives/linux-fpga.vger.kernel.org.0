Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F886732F5
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Jan 2023 08:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjASHvd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Jan 2023 02:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjASHui (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 Jan 2023 02:50:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5D677AC;
        Wed, 18 Jan 2023 23:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzxGBxacEx0ldrD16wSq7g1PlJwCg5E1G1ya3vjA2vYD565lTnhnHueZzNv6+akWYKNOtG0NzX6pwKmBbDqbyO3Pi+Bw00NrRL8l19bd1vMeJPBJ0EQIBmOx/t4xbfUsN07kdMT9dUQiDH3pinTYNMFEGdlNdEEuoMWcVk1WzfBgfBMcdcjR1xpT07w9LE4RF/TND5XM/fCrx09OA51i72hTmhPRB7z5+k/VZCga6Kc6YCmvPo/u32F9j+0HSA/SrKIoZsB5zHNvL0jJzGg9AHq/yCZ00wxp5D/HSZB3cJ8vZy4vyWQb055pzm2UAtUZI9oKEEbfcIBDX5bofW7bnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MYEprceYCi4GvHGqlKPZ6GP9rds92+w03QtbxEBwL4=;
 b=SKC1t21KlLWeK8r9fPNj/HjgbsoHf85pzK7/C0+0EPUyWutGynoBMFkLo1Dkjqkhk5t4h2k0BM0ptCwK36/SJa6wR4jKW+yniZbCr5QLxHe3ratax7f6tAAe/g08pfLCvgNTFznOv1Q2eGvdToRYUcv/rVp6dbPQmR8gWtHga6hepYddrNg0WuE2SYxejNlLGBarjes4NwrVpHebNbq0+33yeUKl/8d44++t3jHWygcAhvNND9LFlAE8YJuT0aZOb/o9CyN2GIjxouyTHsJNfL9CCaPUYt5secoI/VQK4ul5xz1im78Dg8hpAEN/31SLJzQ1nRgc6x3rHve5wR9X+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zte.com.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MYEprceYCi4GvHGqlKPZ6GP9rds92+w03QtbxEBwL4=;
 b=Z9KYAmbkRDdFiapSfmq/Z3+yKRuzwaB3znU0rJtPo08RKCWmOAMPELK+e3j/sdO/Kgm2RQ+rgv2vggK8mPMewdLWz6G8TmFS0zJcuRvdSU3MAQ1EaeAXxNk6K+nJkQRVk0PMmCa4+cyCUTU5W1DqCxBB6xn7eW/ePIqLJsEK9uY=
Received: from MW4PR03CA0299.namprd03.prod.outlook.com (2603:10b6:303:b5::34)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 07:49:13 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::98) by MW4PR03CA0299.outlook.office365.com
 (2603:10b6:303:b5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 07:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 07:49:12 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 01:49:08 -0600
Message-ID: <c42f1077-8049-8c59-ef66-6de477ef3516@amd.com>
Date:   Thu, 19 Jan 2023 08:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_linux-next=5d_fpga=3a_xilinx-pr-decoupler?=
 =?UTF-8?B?OiBVc2XCoGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Language: en-US
To:     <ye.xingchen@zte.com.cn>, <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <trix@redhat.com>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <202301191514074846351@zte.com.cn>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <202301191514074846351@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4c36c3-cec6-468b-e6ca-08daf9f1a7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCm8th4OMdyrGv0ZOhY+6SMpA25ZaIyFPZZv0Iw+hgbUCXJyCxKvEB4/bTo1SkyFJur1Xkk1uZi1zc0/3m8eMo/ECxKWOHC1+fjML5y5G7VWuWbEfuBUN/l7l/wlFZ/y31uYCMr+wgsixu2zoa/EvWJw8K/yYV7Dj3lt7wY5ACp1W7dc6m3ALCQS2YKHl+Q400O7nZViA1G+sZ0UeNYXoYlZFHBvYMxGj/4ydzWi4A0HDhZV+NlEjla6wlLr9zNPV6P9+pv6ps473PxRNgW7xT8dNkco6igm44CfHXg45yZcx1SQVhzk8wDgtGjKJNxRRGthqvQ+Lc7wh1lXu4JYdnVpbO1fMWI/C2xlaXVX3ByR/KMlhmh7R2sUHwcLbtThdIMTI8YGAQYjNihVOs+MvTKCosA6GGCGtaXb0i5V4dFj/D/WTWBdkisQyF45iSxo5JX7tzMjNNA3FIdnSQ7tqOdcTSM7C+sMp8vZtj1/U/rRiPqr2gMBfpO1qz/AuNYIDY82b5pk3BZ1bquy1ZVXFn2NEhZoowptL7/ZhOpr0BblySo/YsTK6prwzFZX9WkAVhkmVjtUSlmvc825D273aeQTLbndnThcoaOEllD1vlYrtADkhw6+L0DLmiOL6GAIzb5V+Yu2uOlUsyRxzzbMOeT+G1AcDFkXB6kIxcva2uSzn8k/foVSan3RGwBeIfFbeYuL2ydE905LYSGp9TCr+HUf6X3soBreaqXOXpvVdSoGunLOLGMca0g7rb+ucE81d2v52FdKAhWQgtA2l3mQqfHT3QcbwgeQGmX8ozB0RDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(40460700003)(81166007)(356005)(40480700001)(36756003)(82310400005)(16526019)(16576012)(86362001)(31696002)(70586007)(4326008)(336012)(478600001)(70206006)(186003)(26005)(31686004)(2616005)(110136005)(54906003)(36860700001)(53546011)(316002)(44832011)(426003)(47076005)(8936002)(41300700001)(2906002)(83380400001)(5660300002)(6666004)(43740500002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 07:49:12.1827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c36c3-cec6-468b-e6ca-08daf9f1a7c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/19/23 08:14, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/fpga/xilinx-pr-decoupler.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 2d9c491f7be9..0039cf11ddd5 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -108,7 +108,6 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>          struct xlnx_pr_decoupler_data *priv;
>          struct fpga_bridge *br;
>          int err;
> -       struct resource *res;
> 
>          priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>          if (!priv)
> @@ -122,8 +121,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>                          priv->ipconfig = match->data;
>          }
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       priv->io_base = devm_ioremap_resource(&pdev->dev, res);
> +       priv->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>          if (IS_ERR(priv->io_base))
>                  return PTR_ERR(priv->io_base);
> 
> --
> 2.25.1

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
