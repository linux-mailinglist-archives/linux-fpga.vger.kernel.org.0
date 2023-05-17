Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3695770609C
	for <lists+linux-fpga@lfdr.de>; Wed, 17 May 2023 09:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjEQHBC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 May 2023 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEQHBB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 May 2023 03:01:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFC49CE;
        Wed, 17 May 2023 00:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrA7XFytCtcATAfitEMw13ow19huwucodbFe4UQBy0yF8UcII1GRKXtuKaKgdjkpyeOaowIKOwAOt2It2G6qSb9eznJN9sAsIBjFHQY6Lj9HuCuXe8bSL5y5Yeht7eALc3FeDhhRcizIiQ3RzhPUKa/CPsjDI3rfRAQndEcHXML6kJi4dzS4Krp7ZR6MbRjVgr4QjZ+nJl8NAw+tlMr/zTXdxe3Q6Q/pM2lJqNkZ6IGiaOR7xd+aZ1dRnajFWY/SpI2+WhrSJpANjTlHldGtdpcc/4Gsqx7VqgAtCEeCr5lj/+NnsjDI551wPOmaUr4xGu2R9F2aokRxmZUDT82K7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+AAeiqSDvGgdvvqiCYvMqiRmJe576l+L1F6gRX3Ku8=;
 b=MswkRDo0eUNrD7cN10sAFKYkrgIbtUe/l2TpcENhWeSYcBVwSNgpY1msHxMmbrYV82P7+m68NKJLLm//98ZxUFmeWqlZCSu7HeCynQILpUwd2VwFSAZzUEJrNFKIAaTsPlaSvoU1NA1I8oteNlsezLP2i1Lup1/jhwt1wnQs7fsoU4+/TiTKh18bmoNAcrUBwGTgDlUf9Gnbfn3ovWSy7mmCM3W6yQAvl0JDEMsHm3mvi+j82OY9me4CZQqHdF6s0uEMAWXewFgGnAYezNQJQo+nSQPq1ynuQvl4Bswe6u6T1+wtyIBxLQyqN8TfnqPOBtZIfvV3KhucGeeDaWHqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+AAeiqSDvGgdvvqiCYvMqiRmJe576l+L1F6gRX3Ku8=;
 b=vMzzF5awAuO7M8hLCUrMMGXKVIFaQNenKFZKQukPFB1oX5AlzjaJSECoivXqaPCxj7dxJ/Q9sGmH5MfbJ02gl3MwKjTZBJL2s0ooLt8Qr1kzeUriuLB9ZM5Y5RTfsYraqUuuogrrD6CNgcCOwXv8/YKYiFKHLNrpywMRDCF4TJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 07:00:56 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 07:00:56 +0000
Message-ID: <8c08ff32-c781-22e0-d3d3-ecb7f0be5d58@amd.com>
Date:   Wed, 17 May 2023 09:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fpga: xilinx: Switch Michal Simek's email to new one
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Wu Hao <hao.wu@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
References: <32514756730c7412018c26b0bb140647f9e9d414.1684244666.git.michal.simek@amd.com>
 <ZGSheQfInrIfeMaK@yilunxu-OptiPlex-7050>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <ZGSheQfInrIfeMaK@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0044.eurprd02.prod.outlook.com
 (2603:10a6:802:14::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 67662183-43eb-48ab-aaca-08db56a47606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQix9uwN2NN4JEiHiQKTHS5Qrd67jgeegcgIkdSVo5sgi5Q1wOcKJkp149k8stKMzhcyQkqc4OZdzaP4y2EEtOYZMiKIjXFuBxO1bPmQYMcR5uckQOpKFb+k93pUxG5aMbpcygtz8cFRZhgwGY16Mj81Bg+IkZA0NlpnpjJUV1vb3LcKh/jxVsC1JoRERZ7CriNPO5mT0uAAyA2zv0Lss9DJE/KwxdhpbXBur8XEYOVgn3NwdajxvZjEb6xk5ObFrLDjcXm+xVeSrt9JdmqwbhaGL+JVvx6/a6+icgjsjN5Ipd0v0037m0HhTbloFFYkB1ksEfm4eD/oa9SfKomf4erlAgz7KKytxHrSjRusg4jC92l1MhWL404Enr14BfTUngXpgzrGaGEdGolNof6Q6JVag8CVYNLkpZtvLQW6UP3XfaTaNJ3W6/CJf1WwIjH7CxAaT/eDZOu1t4EfJmRoDXrTYHgZPSkp2N6u18IhY2KaQ4zKWYjGzzkLiO19pn0YyZim+2ET90rZgBSbEWp+OrmM1iANxJKSXpA9Kf8EI3hWj9/mdUY+Uiud5X46FsmXqcLS2hZMapvcXklhq1Qtm5ELiXPreYs9VptBZCVW90Y8cdvj1VOSumJJNH9HeAlHcj6kvHzmH6RPfE/HtgRXpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36756003)(4744005)(54906003)(316002)(66946007)(66476007)(66556008)(478600001)(6916009)(4326008)(86362001)(6486002)(2616005)(8676002)(6666004)(8936002)(5660300002)(7416002)(2906002)(44832011)(41300700001)(38100700002)(31696002)(53546011)(186003)(6512007)(26005)(6506007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlEUDFOTWszMUZWT3ZMUHlnbWY4SzBJR2tTMURrNlF3VHhqSjMrckNOQnJR?=
 =?utf-8?B?eTA1RyszL3ZPMkwwTDNVY0hUTGdBNXNGUWo1MmJFSVluNFE1WUZlOEdMRW9v?=
 =?utf-8?B?RmFlWnZCT1R3eWR0ay83V0dlNTd1NzVFdVlkbG1xWHFXYW1pelZsOWxRQzlD?=
 =?utf-8?B?R0p4dHE1R2ZJeE16bUVBa0dwSktoclRxRlZCQ0xPUS9RdlpzOEd3Z25obGM5?=
 =?utf-8?B?cnpLelNWTVpIZ3VaRWhsQXhFUE9jTFRNY1piZ1JZbThZRUxKdXAzdHJkUVIv?=
 =?utf-8?B?RUl1R2JFVXdvOWFNSUNOWjhVTXFvT3p2c0JITnFoMGdyY0FsZXJZWVprWVg3?=
 =?utf-8?B?djVkU09ScjdBZzVsTjNadGl6SXF6bUJlNTBVQ3k5dDdENHJCWlNydU1SOVlr?=
 =?utf-8?B?WGFSSmtHRDVUSDJTcndiYnR1NVpjOG9JTW1UTExucENZWmRSN2NNRndUci9W?=
 =?utf-8?B?eTBwVjdCTVZRZGYzdFZTRXE4QlhxaElUV3NKYUdLVm9jRFFSbzlieThhOEdk?=
 =?utf-8?B?czNMZlZmMlhyNnI3YUVLY1Q0bTRNZ1RYc08xL3Rvd2NCdVNqVmtpZ29Samlk?=
 =?utf-8?B?TVVFbm1DM0k3QVUreHA1M2t4d05YV0xLVUdBOU9UT3hJdVhncU1RRWJyWE9F?=
 =?utf-8?B?VHoxakoycWJtMDlwMUtVOVpBakYvOHQ5MXlRSzZLcXJOZnREOVQ2NTFhMG1t?=
 =?utf-8?B?VWg4YW52Zm5RbUgydzYrREt1SUVSZ1FFTUFIUHpoYVE1M1pNbkU0ZjN0Q1V2?=
 =?utf-8?B?NVRlYzU2a2JSRzFPamQ4OG1FZDU4SG9nT2ErRHVzc3VxdGMvUnUzemhNTGJp?=
 =?utf-8?B?Z1YvcC9PWjdEOExXcW9NWmY3NHVBTnRvVk1TcFlNR3c0VVdDM0JkNk1wQ2Vt?=
 =?utf-8?B?L0ZpRW9rZUNtWlhVcHVUWk12ZnM0UHpLeG0vZy9QR00xd3JwMkxUMVkwMlJs?=
 =?utf-8?B?cWE2MzBVczN1Rm9iNGVkTWVOM1BYK2V4SVoydTE3VjFESG1GZWZ0NjBhV0s2?=
 =?utf-8?B?ZjZTaVhzZlR2Z3cwd1MrZi9tNkVqa3R4WjZLWHhNSGdXNFcyd3Qvd29TbkNw?=
 =?utf-8?B?T2hDa1hVRmk5VTU3b2VORTIzcEN5VEdwcHFKNm9YL2xwMUVTcUFuNTdMeGpy?=
 =?utf-8?B?NGlyV245b3BxVldvaEJjUTI3RU5NNzJlVUI2NFFXVi9jQlhwRFpVRS8ySWhG?=
 =?utf-8?B?ZnAxSUZUdHBtbFlBWUJROWplY2Iyc0xhL2NHL01CNmtubC8zUTU2SW1sOGt0?=
 =?utf-8?B?eHB0a2R2TThXWG9lZG5LL0Q2Y0lmQXJ1enN3dHdqeDVuYmN3bGtJRkN1c2lB?=
 =?utf-8?B?OG54K0lBWVhnd1FtV3BKa3NvVVpEQjFhdEx0aERtRXJObmpwK2pYMFF4NFNj?=
 =?utf-8?B?S1BaMkZ2NnhNVEJ4bTRJcHF4Z2s1anlFc2tnRHBJV0ZhMTAxQnFWOUt3S1JH?=
 =?utf-8?B?V2hndUk5UEdHaFpkVUQxN29VdU9kaXRvUDJGQjR4WlV4VlVmQmpsMm1hbTFv?=
 =?utf-8?B?aUtPL1JCMFdVNklIUTRYUnVjbHo5UUhQTkVCOENrNk1BUjFmbE9BaEZMR1RH?=
 =?utf-8?B?aythMTJIWmxQaEt5cjNMK0hPRGh0YUUrM1hVYjJ2ZklJZTB2UkY0Nno0VzBU?=
 =?utf-8?B?czZHUWFGZHpSZmhpQktkcGdzUUJlN3hIc2dtUmxhSEwzdXR0aG02c2lYc1V6?=
 =?utf-8?B?SU1NR3h2ZEJXU2QranFlUWl4OEtsNlA1MEk4OFB2Rmd6Zk84SlA5QWZocC9W?=
 =?utf-8?B?TUlIQjh1YUdTZXlvOFZvaXBxemVvUE5YaStXelFNTWpmV1dJVngyc2MwWEZh?=
 =?utf-8?B?TFFKSmY2d0x3TjNxcHVWRjN6RTZ6bnFRRUlqb3hyN2xjZjh3N3VkVnorSTkx?=
 =?utf-8?B?QmJ5ekMyeVhvTk1kdk8vbTNjYVFMM1k3ZVhIVi9heVV5U2dMbkV1dGZMUWdG?=
 =?utf-8?B?UXZpaG1FNm56cjNMMndmME1uZ0pUbkZNWUgyaktzMTNSdXZKa3IrY1JHamxE?=
 =?utf-8?B?QkhQNkNXSnNPU0NxVDRxUENKcE1oYk5OQW9OcjdxcTd6V0hJeDNpQ0F4VDVE?=
 =?utf-8?B?RkpjL2tYZC9XcnVVYlRiQTFXZHNRS0dzZE9pK2hrNlNTdnpuVmV6aytIck9x?=
 =?utf-8?Q?BvMz1kuU5uvk/iZGSQKI8F+bR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67662183-43eb-48ab-aaca-08db56a47606
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:00:56.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1icD0Kvl9C9W650siyT+mdudPy9Y+uCR616YbjZqdDrmjLkMIFfybHEq2g1Akh0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/17/23 11:42, Xu Yilun wrote:
> On 2023-05-16 at 15:44:30 +0200, Michal Simek wrote:
>> @xilinx.com is still working but better to switch to new amd.com after
>> AMD/Xilinx acquisition.
> 
> I think maybe not necessary to update the author.

I sent couple of these patches and waiting for reaction for this step.
Author is not changed only email address/es.

Thanks,
Michal
