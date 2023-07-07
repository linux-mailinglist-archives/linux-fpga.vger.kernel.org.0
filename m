Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8F74AA22
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Jul 2023 06:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGGE4I (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Jul 2023 00:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGGE4G (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Jul 2023 00:56:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70861FC7;
        Thu,  6 Jul 2023 21:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQOU9osGnotsMW/3CUSQsj8h2U1RQe+DeZ0XcikeeL/7YZ79VYKR1ZXFjBZP0kpM4xVSTktMiqUTGEklEUpmQTmCR7hM38SxriqJg0QKDwrhPJT1EYtQLg9SKIP5UwOTib+XySCf7LiJD/vb363ggAfAc4O2tU5lDHMev97EQ60H2nFtiTqFgN2hOg7W+gcDvBQLGdHgtMkynKkCYmO0jj2GZrj6vCnSyJeZC0lDzC+n7mOLaXMKMSsguoRPY7nVMnoElXA9UxBTp1vPvRfPN7E9SAm5QN7DAopNrad6fEbVIOS2xfuAXlnTfKbwvTl8aBoKtjl/dIZSgQHAiH9V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY6bIV/XhnFET4C+k44CDB3do7v4rQl+qhCmFGd1NAI=;
 b=XtT45is1wtFeaLVKp2Vu0Youga03A2saR/QKsIdZ/VoPUigMfZW7nrjYrQbA0gugpxcINhcZNiAyAVtGEir88AWlKToPzMkEfge6kSiBW/NrkBRkWkhe3zgHTIGw/KxiQC+FCc95wMC2K9RwFIVAaAOiO3Ul6QYNdMS7MkI3W61uUEFQZeMDYT299AM4SEM7RTGHLozOWdLdlb7WZEog0x+/b86ls1RsKUGu7iy39YmownIqrrdsvYaKeVwULSCkEaOsObo5U80iLiOwrFjsuXWlghqzKyhV3GuKjDRR29kPQ+8R6uyY7WPs63GiwViAA2F/SLHmIk1UfnWLb7u+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY6bIV/XhnFET4C+k44CDB3do7v4rQl+qhCmFGd1NAI=;
 b=HGcgyio4Iosq1x42sfhvRHHTtRu7CJZ2fI58excgZozzx4OngEKTYs+HY1Szv+rNgalfrmhWLTBZ84tfPxy98sSRtwbNOylIZRK0dgJD6M1jcxW2/ilF6v0/FI1ZvKNDIJLt/d2yhbWTcyJxDnmJWKDUZQQb5Qu3kXUexD2oVEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 04:55:56 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 04:55:55 +0000
Message-ID: <73eaa72b-9ee2-3aca-b5b9-bc53e6a40467@amd.com>
Date:   Fri, 7 Jul 2023 06:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 8/8] fpga: zynq-fpga: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-8-frank.li@vivo.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230705094655.44753-8-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b49892-85ad-4b6a-34d8-08db7ea672ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyEiGW8bQJCCxIPdiMON5BlHdNOnDmtgtLxeWRRR8EecsA7L11ZL6F3oNv2TCNVdyr4ehn4BYzC5RkyCQpLIam6MDN1m/jCUuykBzJXsffuq7XvxmwCHyXUnMXZ7UnPyiQg7ylfALhnYIv+0sOHEOZMUy1iZ7q2TEZ8io2//TLTkJWlUCiJamcf3tM/7T6BtgjAQ6q4N/P6jgK8xq3tcWFmXIlaY1MvB/JfV+LmPjWSShVWFZezwX0JY8LcFCwLmQNh6JmGZ6NbplacN/AEUkNW1hC+GF8Nmd3+6jcWFXs8veGwF/qEIIWPMt0yvIQoT1qx7hZgyxlfV+Vj+B/LRh8LEMMxiaKKYS8MdxYs8FpskctAsr8Z1JSZK+tgOKIXTkyfTNLP46bMuVw6yl0526NbjhlKYngY7oAlX1MG+2wuxijxTP56cLuRO8SAY3KVLTh9VJI0gN062UFzZQAm9C8TVFZVg9sQ+wnaZKsrCCi0xagyPtAviH02uLfv92fCpradI5ejJCUXapxcx2zkUgrhvjCgQEy/ndC9eS0sI9pxxy4MLEsbEpkA0qlI2FAQq94WBEKfBta8Weiv2JHw8+X6zUDARMdoXrYtetp6zmFHccZ5gyrjGhNrwtE6OCc/+ymGVFF181D6cpnL+TSK+EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(6486002)(478600001)(110136005)(6666004)(83380400001)(2616005)(2906002)(86362001)(31696002)(36756003)(31686004)(66946007)(6506007)(26005)(53546011)(186003)(6512007)(38100700002)(8676002)(8936002)(316002)(66556008)(4326008)(41300700001)(66476007)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzc4M2VOaEVBRmJISzBIUm13S09LTmp2Snh5RDJEcVByZ3JSaDMwWk5tbG5j?=
 =?utf-8?B?cVNZUXdSUitaNEVlZXBNa21tWEJVTWZlalg2VVJIK0FLR1BXUmRRK1ZDV2Rp?=
 =?utf-8?B?QjhVVjJWeGlCd3I2dVd6Q2tCRFExZXZCNFRqL2RhSjJFZU1kbFV1VzNyenI5?=
 =?utf-8?B?bWJjbFVvVFB0bWZiVmR5SGJXVEg2TlEvbHFEOEQ3VzR1NWhSeTlYYXZ0bkZr?=
 =?utf-8?B?KzYvaVFwWUhWelNUNWR3QW11U1FCcHUyVUI1cVU2L0c3cUVxY3VJbjNkRWhI?=
 =?utf-8?B?RkpPZGd4VjBLVy9ic1o1RlNTdCtpaWlKckNHZ2M1TW5scW42bE93NVRUL0Iz?=
 =?utf-8?B?WjZKak5wMUJCYWJGWFZtcnVlQk5mV2tXSUJmR3djNWZ2dkJjTTk5RUQyT0ts?=
 =?utf-8?B?RlI3M3gzVTVYc1Ntc2F5YWhjMllaZFBZVVBTaFRBc3JucytCckxYZWx5ZEdv?=
 =?utf-8?B?MSs1WlRaeWNuaDcvYVNSN3EzTVZSaWw5RCtnd2JzVXpneXlDdzVYOERkTWNo?=
 =?utf-8?B?dXZXOFVvRVliRTBVU1g2bmVvTXRheDhlSDFlQitKemVzRG84MlQvQW1vVHR6?=
 =?utf-8?B?ZVZtTHJTUC90VUFuMWdIZG84azdYSjF2TGhUaUJSa0oyb3ZpTWMxU0lQV1h3?=
 =?utf-8?B?d1c0SERxMDlVdEdBKzBiNVVFdkszdkN0TzRKbnIwOTNXVEIzWHpkYTBPa2dG?=
 =?utf-8?B?T1pMNGJxWnBYeHJqZ3llSCsxUFpUanQzbmdqeWYwd21ubEw0eFhlU213elFG?=
 =?utf-8?B?OXF1MCs2YWh6Sk95SVRnTFFQeldMMTVvT3VHMFpvNHlVeU9CSHFkUm5SZllQ?=
 =?utf-8?B?eHpRMUhWNnBpYW80ZDBNREZpMGJUWXhWWXp0eW0vVUlYWkNlaFd0Q3lCVzIv?=
 =?utf-8?B?dk1TbXY4eVB3NWlTSkswTTRwblNEcmYyT3BHNzB3MGZYdHkwK0ZUbVNTZitY?=
 =?utf-8?B?cXhYMUU3dkhrTnZ5ak56NVdzOEliSEpSZytTR0Q4L05nTXF3QWdLbkRJeEJ4?=
 =?utf-8?B?QjUvQktlc2JOOTFST3ZOMVhXMVp5ZUFqaXNXOFNQQnFkblFnNmdiN2hDSnMy?=
 =?utf-8?B?am8vUnVBL2pNMHdyN0pmeTZtb3FvVHpMQy9yeEpUYkcydzJGdy91bDBrbHpq?=
 =?utf-8?B?aWMxNTlOQ2JVeFBqa21Qc2JYYjRXT3ZXeE1EeXpGWnkwYmlpcUwxc0k5eUND?=
 =?utf-8?B?MU53cXEyNDJXaCs0b3hHZVpDNmN6NWdvcTN5NlJ3K0xIOHRYR0xqTVB3MUxW?=
 =?utf-8?B?QmJyRFloejI0WllwbXJxcHZVZXdBcDliWEJ0ZVRJc2FKWkZZL2NCdm1GWEJL?=
 =?utf-8?B?dmczUDNjUVBtcFVmbkRXYUROd0FXR3JTTnZ0L1dEOHVPMCswbFpzRUtPckdR?=
 =?utf-8?B?aU5SNEVWRUpwTzF2RnhTZHpoT1V2VFBLQ0oyN2d5bWdLMndpRm1LV2E2b01B?=
 =?utf-8?B?LzhNU2Uxb1hPVTl3ZS83N2lNSm95d2VWNklOcGNCRld0dlBZT2hoUFBwSjlx?=
 =?utf-8?B?K1I5TVNIUm1ucVMrdTUzNXB6NnNjeG41QWw2b3h0a3Z1U25FQ2g5azduaGtk?=
 =?utf-8?B?clBOaUNXRjB4QTZTeGt5ekdBS1I0RHJrcWJNRXpoVmRwc05keHQwVEw3TUg5?=
 =?utf-8?B?RUJSTmZTNEgvUkNsQVdTb3BRb21xSk9HNCtpVEhsam56V0F1bE83TG1BR2RY?=
 =?utf-8?B?MHEzaE5ZQ2xlVkFNdnVQVXI3Z1pqaDhxM05OREV0VURySlVUZ1JPWTR5TFhR?=
 =?utf-8?B?c2RNZkVLNk93T0xjbDRyTEcvWC9PRVBISzBzSGFHQU5vWG14ZHh4OHQ1UHZK?=
 =?utf-8?B?SjY3RXo0TWFWQ0NFQThncmVsNXdqQWdaOFVURVE5WlJMMnJlNkFvbmlzbTF6?=
 =?utf-8?B?Um5UWTZhNHdaQ2FrMDBsSEx6RVplYzg0WWhTaWtyM1NGSHo5RDBiRmh6amJR?=
 =?utf-8?B?TWYwalVDZVZabWtBTGE4NDc4ZmdFNXpDb1o4Qk43d3prZTFmdVZ3SUM5ZElN?=
 =?utf-8?B?NFUxaURWdXJ4NHcxUzA1QWkvMmRwc2VPU1pFVmM2enY5YXptZ1RHUFgrT2Nz?=
 =?utf-8?B?ZlAyZnM2N3pZbDVkSGxLYlUwOEQvam9LME5rZ3k5TUpMblpGK01ibmp0RTY3?=
 =?utf-8?Q?gLNqgqPZ071z3gcQAG9HyFIii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b49892-85ad-4b6a-34d8-08db7ea672ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:55:55.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NROfBFjhvTQfPRVyJL2SbXWX8C6YllW1JIrefsX0WQf694wq5N5x/4A/vToSqrFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 7/5/23 11:46, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/fpga/zynq-fpga.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index f8214cae9b6e..96611d424a10 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -555,7 +555,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct zynq_fpga_priv *priv;
>   	struct fpga_manager *mgr;
> -	struct resource *res;
>   	int err;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -563,8 +562,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	spin_lock_init(&priv->dma_lock);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->io_base = devm_ioremap_resource(dev, res);
> +	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->io_base))
>   		return PTR_ERR(priv->io_base);
>   

Acked-by: Michal Simek <michal.simek@amd.com>

M
