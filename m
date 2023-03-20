Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB26C0B87
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Mar 2023 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCTHkr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Mar 2023 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCTHkp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Mar 2023 03:40:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A589D2D76;
        Mon, 20 Mar 2023 00:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbkhVctNw7oow43wv/guyctDEliuE1m8bn55sADEWmH7tSo65CETnuCooBsCFmOEhdlv+wCs8eRRmhZgRQOuf36i4ItzqyuCCP/gBYvIoiHMnFoYpe97PjhXQ0IghGqDuvHsngW8AwJIEgfvHm5dvkPn9jD2L4+Mhv+2Ki/3pajizW0zr+6YE405P1kgelt634xpVkaq+zuv+Jxc5idQ9B8EqABR4wd/PdydwpbRPA+i2ASfmJpKiSFOqhq+3H2GKOZT3MTVT7cX+4ZxvpSj3a5kSSPyB/K/gdEEMl1mYcymMrAcGahqrYlvdu8t2u6SJ1KoUI1o0n3LottzqEr3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBgFXAWph7HkBwyDPK/PJEAQ3F2/w4GxqJi4NR7EgHk=;
 b=fseitYIKnkFy+ln/5AcibtNj8YpMbFG1Ic0Ct+oPDS72P1+2liBGhs1ivx62Lz85i6i67gOTZ6nqNNDZjAs5OBCnd8A/OroVaRFxgonKyzDgCT21RfZys/Vdqc5YrOPnx2jIukVccwD6OkituTb4gX3hobCf1QwNmyEYiYPp3X1A9z3biEThne26OR1E36W8UeTLXmwoXhGDDSq1lcTQC4o0t9YmcXIh05EXpmYxXKnxV5a7LLPeitFOMfMlPXeU42oK7U4zELSSvf5CF5yiUs4u52vhI8buea0P35KXe73Ch5Gq++1aGJksO9ovwl6KXBZu1ZazkrCGdOnhosSsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBgFXAWph7HkBwyDPK/PJEAQ3F2/w4GxqJi4NR7EgHk=;
 b=K0zWuEtXeEZDoN0LJI79GrmHj7qfZqtQCjJ8flMTEVSAEN42hUee6SR35hbcGU1Yo0NtlDmCLSIJK/6rLr7swb9P77LJOHprUGSp8yOvlbJIdXQ1WvKd97BMyxOT7YBYXoALKlpcUDG5OmyE2OWFqyvGHRwk0ktqhzR6Zvxy4JE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 07:40:35 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 07:40:39 +0000
Message-ID: <c8eaefed-e1fd-e0c1-7e8f-561c20632646@amd.com>
Date:   Mon, 20 Mar 2023 08:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: remove unused
 xlnx_pr_decouple_read function
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, michal.simek@xilinx.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230317230617.1673923-1-trix@redhat.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230317230617.1673923-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0049.eurprd02.prod.outlook.com
 (2603:10a6:802:14::20) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d9e40e-edb3-4386-be72-08db291666a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7qjR7cAFgQfA/vObpH/9Jl6nAtUCev/LeU1mZVa9c5cTNVE/oXG0/jnUpN6HgG+J33vy741Sf8nOD3TET64DF+T86Ln6kF232+ffRnslAzuY1Ob2+ztMa1NO9QCR9AagIB8ViyjOcKK11o9tpgz7qc0Vlq2or002xp0b8Iogrdvv3BiQlqdBf3p0152zDARo3GwgvTX11DrCOqqIImqf0LWfWLiQwYQHjqJISZmFXKDzJJogT3dAqCtSmfnNd36DOu/0p0p/Cq3HsGF08nmpU/kYVERXDX1u6cIrhsDQV8yV9ntYnGEnqQCqPic3d8XAa7s/ieEjhl0BdVC++Dp5tWnYkj5zZvMaLb1hi7pr3F+nMVKdzmVeOx3HtuO2LC82Bh8c63ccHRY69K5cIMScP68Es/q5An2tuNyeIQ8vS1lsXwU7YyKCrHmAUidC6peSosMKc/hd8G8NTqDAKaOLZsapWZipg7o9p/MjnbZ9B/knS1ks/VES807owj9mJeQ0Nku0n3rixNNmJrhxg3BH/5kfgmPZBvSwT6hLNJcZ24PfFEW7y6L7yzJuoCdE4M/ImNJdYLgTsHSQRNRt7P+lIrYXN0rIbmRLHd56rzDbcLmQ1tl0NrvP9oIL3JSyxAZTOml+oIgyfpm9eEg8fJXmch8wsmsDnjEIkZQd3MlWRQulbw3dyuj5Il00Spn4q2EWegIKNNvLh/QUQX6CSP7W4mBXgj6f2giqxEpPrZ2HPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199018)(186003)(6666004)(478600001)(31686004)(6486002)(83380400001)(6512007)(6506007)(26005)(53546011)(2616005)(316002)(66946007)(8676002)(66476007)(66556008)(4326008)(8936002)(44832011)(7416002)(5660300002)(41300700001)(38100700002)(2906002)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RhdjZKU3kvcmtXbjRiVHNkRVorZ0FTeXJsOFBGamFISG4wYVZLUDhzY2xh?=
 =?utf-8?B?RUczWU5kS0gyYU43eHkveEQrelFyODdsZ1o1ajdMaHdyRStFY3VBMnFhVUtN?=
 =?utf-8?B?bXplZ3JRSXd5eEx5d2F2M1dDWG11MWVjTzBBRDE3Y0NTWjlPWXBiYkdGWFVq?=
 =?utf-8?B?TWQ3UGI3aGZMdUpyNVFxemFCVGorTUhHQ3VXTUZxV0lhTXpyZEVDdmViU0pl?=
 =?utf-8?B?Uk1DdWw2V0xVNEpyT01MbDhxaHBmL3pDOG9sckxFcjJVNVpINlZjRC81RVFL?=
 =?utf-8?B?dW8vMkxZS3N0UHZONWFJYTRJTEhCaGlKZzZIVWVGUlYxS3BKYTlhTTJudy9Q?=
 =?utf-8?B?SkpLNWZpZURic0dUMFYyY2dVaGI3UUtiQkY1cmttRTRzSnVpMEprZEJ3Z2dI?=
 =?utf-8?B?d25xVlpaWmVPbWVTSlhkUTA4MHJxVG80TGcrbDJLbkxxd1pVc0VtZ0lOcWd4?=
 =?utf-8?B?dTh0MXdndFBHMVVrVGh1QlVDcFgvU3JNZnJBVWFSeFZkVmNSN3l1ZTFQVlJt?=
 =?utf-8?B?MlV4QTVBczF4NTFqSmRFTUlBbmo0S1REWFhORGtsbzRjbHhlMHB0dmZvV0Zh?=
 =?utf-8?B?bXJwL0V2TUtVMnJnTVlVRHhYZjNxdTdSNzk2YVhiTzdBVWxGenY3UjNSVVU3?=
 =?utf-8?B?eDhQcUZjYXYveElRakVoaFNOTWMvdzU5NEtqdmQzYWp0aDdHN3B6Q3J5WnhJ?=
 =?utf-8?B?dGJka2JFTUlGWDlMWEYwbDVnbUZwM2RTV0FFa1NmNktsQXBDVjN5M2hVS3pk?=
 =?utf-8?B?ZWF1djZqdkkybm1hR25tMEtzRkJYNUIzNm93WG12b2lvcW9uMFpEcjFNSkcr?=
 =?utf-8?B?eWlhVXNPM1VYdGQ1Qmh4d2tTeDhJTVFpUDJXekcwbmFhVmxBTm1NRlZYbS9L?=
 =?utf-8?B?NkRYMHFvK0ZnTFMrMHU2V3RPVzB1TVFqdDMrdlR2VWRpY1VyTkFxVEowNTRG?=
 =?utf-8?B?ZmsyU1dkOXpwcnJpek5VZkx1Nm1KdVlXN1JpVE9ZemxKUVY5TkdrQ2o3VWdq?=
 =?utf-8?B?SENFN0lxejNTb3h4TnpJNkxDNjB1SUQxTkJHNjdNb2xKM1QrV2ZFSm43djdG?=
 =?utf-8?B?aU1BK0ZQSHV4b2VKbTdJYlZhRGh3ODBkZU1oZ1BCS1VMS2tqZGk5VWM5emh6?=
 =?utf-8?B?SWVZKys3NFAyV1Q1c0FFN1R2OUZQUWU1M082UjRUakp3RTJGeGNqY2ZGYlAr?=
 =?utf-8?B?enNUWGIwL0VCZk11dkdGOEszK3FSV244RFVOSFB6ZFIyQzNDNG4vWnVnZ0s1?=
 =?utf-8?B?Und2QXhRSWM2RzQwQzFHQ1FtWlNwQkNJZjQ2S0d5a25rd2R6RWJ5NEV1aldj?=
 =?utf-8?B?MExjUk1DUjVsZXY1L3RqZExoc3FBTGVvbk45OG5WZVF4WXNOMjVlQ092VjlL?=
 =?utf-8?B?bllzN1FGQ2hiellXK0JrMEFKVWl6ZXVKdmV4c2VZTDF3STBSUWdiNXcxRGJs?=
 =?utf-8?B?U3M1OFNzT0V2cVB2bFlkaHFtNE5KVE4wMmNXY1JSdW9RMVFKSmo0bmdCVitn?=
 =?utf-8?B?cWlIUGhHL2pXKzE0K2ZTcjJNc2hvWlJvcUtwOUJ0VnpvNDAxNkVtY1FabWpw?=
 =?utf-8?B?NmV0SElJMk1RaU01cWozbkZ6K1p1U3RwY2YrOUVTYWU5NHZDZ1Yxc200cW9l?=
 =?utf-8?B?VjZYS0U5R0lVOUl4akJuMTcxYzUxY1RPUzZmWERoRmNkeVlyNE5FUFBJMHdl?=
 =?utf-8?B?bXFlUW1LZWlXdk4xL3p1amptckpoY2dSSWpsRHF3V29vRDRaT3l3OE8xOGQr?=
 =?utf-8?B?YmxsZkdtay9HS0FUL1hRUUdNSjVZb01HTUNMaU04TzFWcXpma01LSnpTZm5M?=
 =?utf-8?B?TjN0WHBTMU43eStJeWt6Smk2SlZYZUFwVzBXNzYzWnRGcEdzVDQvV0dqaFpa?=
 =?utf-8?B?Zms0ak8zUmZZQ3lyZEpLK0daOW5uTUZTeTJKODNJYzFNS0VWUkptMFFpejQ0?=
 =?utf-8?B?MWQ4UHZyUG0vWCs1U09MRWhxSHpreUNGTm9lUkxVUm85VncrMkQ4b1FIbWtB?=
 =?utf-8?B?TW1nc3hYM3Y5MnY2QVRpVDVlOUhRa2UzaUYvN0RaWGp2RU9ubVFHMVp6VDVt?=
 =?utf-8?B?enhERjBwNTFoZ0VVSjdjaFgxTnd3b1FoVnhUSTNMdTdaUmNrUGtLY1ltTFlP?=
 =?utf-8?Q?zG+jeI6+RfN0kgQTjI5SQoRj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d9e40e-edb3-4386-be72-08db291666a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 07:40:39.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4r+LmxfDLmx6EXebK0ISAJtsnFd1G4PQId1w7MyEfed56Z5zZ8EQZbwOpkXwE1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 3/18/23 00:06, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> clang with W=1 reports
> drivers/fpga/xilinx-pr-decoupler.c:37:19: error: unused function 'xlnx_pr_decouple_read' [-Werror,-Wunused-function]
> static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
>                    ^
> This static function is not used, so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/fpga/xilinx-pr-decoupler.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 2d9c491f7be9..b6f18c07c752 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -34,12 +34,6 @@ static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
>          writel(val, d->io_base + offset);
>   }
> 
> -static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
> -                                       u32 offset)
> -{
> -       return readl(d->io_base + offset);
> -}
> -
>   static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
>   {
>          int err;
> --
> 2.27.0
> 

It should be fixed like this instead.

Thanks,
Michal

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 2d9c491f7be9..58508f44cd49 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge 
*bridge)
         if (err)
                 return err;

-       status = readl(priv->io_base);
+       status = xlnx_pr_decouple_read(priv);

         clk_disable(priv->clk);

