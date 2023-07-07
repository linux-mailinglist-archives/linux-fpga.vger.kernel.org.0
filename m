Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFF74AA21
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Jul 2023 06:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGGEzq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Jul 2023 00:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGGEzp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Jul 2023 00:55:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763ED10F7;
        Thu,  6 Jul 2023 21:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUsUoL6jPePpGLZZaqkJ8KezENtY/tO/dLW7NOxOZ0xBFOqhevkmMW1TanZFefbT4oka9yTucJIkS47iLqrjM+0H8niXWbYaC56zpic72M/VkGL2zaWoReIdkcrsn6VzU5PO7dg6zn6Yup47KuCo642Nqmq0q5zU2+Z6EQNgA9nrD1s6hShZpj+n9kIjHoCwkXWS25ntfaJc7ppYOLx56cHHBNkF5QjPuuQDLKwbVhACpha/C1UGcL1GLzYeX1xXUrkYnVIWxm9vnZYnSZx9VgcnNCaulSfu2rNxeVSUJM7IF7JVcDhAXQkhOBQ4Yx/QoIJpeUxGbMtxsHfEWeunjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovjxO0fBJUuHu53idbUMauuxR410UPCE02AtvPm7XfY=;
 b=oCKY0dlBGxFelqb3KbJM+YvV1mEPkF618YjTf5CyYfD/w71bzKMbrcFtRTCbeqVn/aXDexA3lOChUBpsvgiCy4kRTIxzzdwKuRoi5QHLbXB+GXZoSOzPqkUwZSe30uw/74GnxNXAtB5rtyo5PwMNRQnxxq/XYCs/ZUd2Vs2nuPQsD20dIbWCnNye3afihkQL+RwxCdbkw/iEodV/Qwej9wWp98e05RMiDD8aU4SH4yq/7YrpqxLOOipuMyNMW+lf6OfwaUvmIIabbfHgMKaqqliAS1aTGfPNAuFbeGdDzp6zEyQQf+4nr+t2aqhYhYBoneRxEZecU/QJNPe6PJB8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovjxO0fBJUuHu53idbUMauuxR410UPCE02AtvPm7XfY=;
 b=xHmNj8L1xl1XjNY/RyeF9PWzV8W09y8YNc/mh45hQ5slM9/2WRtXCE5wTWiHgSbF91a34cJfbjfwfp7nLwBGfAhHfEEEz3KGpIQW9VEGfpjw3JO40EXch+FISRO1yi/3thH4QnE90sFSi73HoX7FUZSgkovoVNU6mHxZM2D1n5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 04:55:41 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 04:55:40 +0000
Message-ID: <8aa1704a-f34e-1bf2-76cc-1324b0a0404a@amd.com>
Date:   Fri, 7 Jul 2023 06:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/8] fpga: xilinx-pr-decoupler: Convert to
 devm_platform_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-5-frank.li@vivo.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230705094655.44753-5-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 031dcadf-b146-4a64-a774-08db7ea66970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGV094P8+30x/C9KOFH2prGuNEtb0j6i76GVnP6huc1GTm8BIpGN8xYIEYocBe3fTllEBoXv1EmMmyIqQKap54hCN7uHWmeWRyS7BXuc4aeEzui+UxUCtAo+Zj28DyrvWJQV1Zsbg6cUelIB1duCo96HWPEv3ePnQcHqzJVjrJQhTIL+KO/m125TPpyuNr8J5L8x2jsMJxIOBnRFMfoRGhv+y8X2gpDKdmNneG4valCZAV2D60Kxgruer2+DCEKk2VUHooJiwwtbbWI3suuI0HqlxI6o9RQiHh/CLrs5Y/4MiHATUWgZpWW5z/LzwOHfIx/pEDCkWpq5C16NXVv4knKm/8bPWJgioaJCgIONA/bN7EH1EFmR3Sl1h9Mz9lN91qn5JTxkem8SPQ2M1/AVjurN8XcTE37FIJLXUnhm6TLwBBCAfkXZn6GQF2ndXeyU/LgZYp6cFbuCeNUY/AaEI9RAtH1ExzR6K9SH0gdhdNSvBclSurJ2Y/PJsJsX83KHmvPqfYkVkoU58syLx4X3ukDJzLQb9OmoNvA+wujxjL+izKS2WUsCRnLMH5JRKn/lvs22UQtzeQl55YLBNggagYG2sBMCyu+F4MbcS+UG2SNwVtR5EnzgdG8yCTxWQCSnvJ9uzcOmU3DfdtMQCztBww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(6486002)(478600001)(110136005)(6666004)(83380400001)(2616005)(2906002)(86362001)(31696002)(36756003)(31686004)(66946007)(6506007)(26005)(53546011)(186003)(6512007)(38100700002)(8676002)(8936002)(316002)(66556008)(4326008)(41300700001)(66476007)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnM3cld6MkFRVENhVVFidzNNd281VExvc0l0cXFBUGhrVktxdFk5S0NBTHVa?=
 =?utf-8?B?TTViV1RDKzBOQWNodEd3UFlteUxBcnpMSE85Tkw5c0RITGVhU0YrSTlYcFpS?=
 =?utf-8?B?OGlqZkJUWS91MkpmNE15NGRwdzY2TkhaQXBsV3pCUHdUVGlKM0dXdUc0dmw0?=
 =?utf-8?B?U2NpVnlzTERNaHh4Z3lVQmlqcUxaVlV4VTJORTBsZUVWMFB6QWJLSlB2cXZ2?=
 =?utf-8?B?eGxFdmEzbG5IbFB4REd6aXRXVDQwWVlVUzBPcUEreGhzU3I4VVdrZnB4SUd2?=
 =?utf-8?B?T241cFlYNVpqL3RZY1BhbGRhMm1mVFFVcVZRQ3hSREhUMk90Mm5wamtJMVUw?=
 =?utf-8?B?dXdITjU3eWFsMEhGMlVVNGVvVy9XbEt6eE1EbituQ05URmdKOUtCdHJQRVBp?=
 =?utf-8?B?bGVlditGOWpTU3NMbnlZQUMzOWVycHRkOHU0ajhZMHdkTVVVUUhjVGQxMi90?=
 =?utf-8?B?OXJVei9yZldMSllWSmUzUEdIbHVUVXUwVjJwNkNyZkk0MVk0ZGNOR3I3ZHhF?=
 =?utf-8?B?NlUvdmFhbVFmcU4zSE8rSDBkUUhtMW85NGJBdXBWU1QxRGdBZTViNXA1anBz?=
 =?utf-8?B?UWhubWhvek95VWhEUTFyR2wrKzF2UWdDVlVBc0JWQmxXeXBOWGYxYnA0NnJk?=
 =?utf-8?B?UFEvUC9xcGlMUFA1MHhadHdNNVZIeDc3UGlkQ2pCVnUzeGgvaS9KcFdZNm1t?=
 =?utf-8?B?NXZMNE1iWUxCMElvb0FOMkdqZ0JpR0ZFVys1Slcyb0hDeE11N2ZJSjZ0QmVC?=
 =?utf-8?B?TG1FVDVFNWpuTEFDVUUzZ1ZSQS9ocEpUSkQzSGdyaEpBQ2tuakF5L1BEMzcv?=
 =?utf-8?B?alBrQkNIUzU3UXBScXRLVEgzNEVWc2paVU1uQmtQSHkxWmRhZW9WSFBDbEdx?=
 =?utf-8?B?UWw3Z2JhanF1S1VWVVBRSlZxUTdxYmNQcDBtN3hIcWtVU0xGT2VyZlRoM3J5?=
 =?utf-8?B?WVJKZXFodnJmZW5HN3EraXB1TWUxZm1ObEc1STJxbEFrd2ZIWHNpeTVEaHlh?=
 =?utf-8?B?RGY0NWJlRWN4UU5QNnBOWjhVdFZpc1Jab215Y0RvTmNUVEE5MXNHTk9pSjFZ?=
 =?utf-8?B?eUpUTlF4Y3V6M051eElmUFVtM0NIcmZEWlhvNjJaQlZLRUNTZE9jV0I2UFlK?=
 =?utf-8?B?T3lxN2ZsQXhGdTFvZXF4ZWxlU0dTbHJPa20rR21DQUNkcjFDSWpZMnJ1bjJK?=
 =?utf-8?B?S2hJSTN1dDJHYS93RDNYUmpOV0FxWmNycnhYYXoxd1loVVRKOTZKZ3hUZ0Vo?=
 =?utf-8?B?eHpzVjQvSktOZjBNUlFKVnBZTXJaME1VcGVVWk0zNXZzTG1LcVM1L3E1eXZO?=
 =?utf-8?B?R05aZWtQaHFwcGROT21KajQ0OXBGNE4ySXdlMWpibXFRYVRUcFR2OGhtdWM2?=
 =?utf-8?B?VmEvNnd1V3BkMVpLSi9vWnlBNHN5ZmNsZkoyZm1iSk55MTlUeVU5K0N3c3F2?=
 =?utf-8?B?dVdoaU9kenJyTWc0Tk5STXFBTWVuNE9lUXpWSVRzU2EzMUhzZU0vWVlRWWNy?=
 =?utf-8?B?azR3Zk9ya2NvbjZjRkZFNVBUTHN5T3BCcjhxNEFTV3F3UjJ6OWN0U2g2UEk0?=
 =?utf-8?B?VU41Yk5JeUx2OWwwVis5dnRRSFdCSDZKcXRrMk05d3JHZDBsNXl3OWlXK3VX?=
 =?utf-8?B?YzZMcFp3djlKWjFRdm5mV0VrZGxrM3RpTWs1Q0J3Ujc0UEsyYk90UExHKzJJ?=
 =?utf-8?B?eUNKMjJmUGhoczFPeFR4ZXB4MFZDWmxwVG9TaFZDdkxJV0dLRUxjWmZYVG51?=
 =?utf-8?B?eXdYNmU3OWhubjhYUllkb1FWN25aV2pmYzhRdjlHK2EzVjdSbWdGdW9KdzVB?=
 =?utf-8?B?YnJjVDUvekJ5THJ4Q3RvUHZPR1RlR0ZuZk1GZUk5aTg0cHpRVTk5OFRYOFJh?=
 =?utf-8?B?dUtabXova2didHZXaUJkWDhmK2F1NkNFNzNXNDl6Q2dCd0hXdElMNVMwdFdC?=
 =?utf-8?B?N0Nsem8zSkhOU0xmL2oxSWU0SC85R1hPVnhSRm0wRi83SVdKTWc3aVMrZmVQ?=
 =?utf-8?B?dEU1eFRvcmEvN05jZDM2cjJyOVVHOW9RcFpqWmtQTDhkWGVPZHBhd0FnSjBu?=
 =?utf-8?B?a3NJSzR3alRxUmVOQkxwbm1vZXcwMEZyVlpkbFE0S3JXSVpORXBPdTJ4RkJs?=
 =?utf-8?Q?QCNUAnypgaDV6l1gkk5RndoC5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031dcadf-b146-4a64-a774-08db7ea66970
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:55:40.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GCKwiBNpHKkTPY4znrRM6NyiTL0IsDYzltqDPb0xgRt1RiUXnASYcjYyMLP190z
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
>   drivers/fpga/xilinx-pr-decoupler.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index b76d85449b8f..208d9560f56d 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -108,7 +108,6 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>   	struct xlnx_pr_decoupler_data *priv;
>   	struct fpga_bridge *br;
>   	int err;
> -	struct resource *res;
>   
>   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -122,8 +121,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>   			priv->ipconfig = match->data;
>   	}
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
> +	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->io_base))
>   		return PTR_ERR(priv->io_base);
>   

Acked-by: Michal Simek <michal.simek@amd.com>

M
