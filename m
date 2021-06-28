Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593E13B59D7
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhF1HiJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 03:38:09 -0400
Received: from mail-eopbgr80113.outbound.protection.outlook.com ([40.107.8.113]:23874
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232394AbhF1HiH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 03:38:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UscbwJKDZ+gEdcEiF1VYG+agO78k1lSxGbBsfDw+429pLJNoXrag8AuNTIkQX1z1y9SA/ztlPRcab4d77o0Rt244op2AiP8LE4abOSvspQt1Wk+Y6ZzftemSVhElX8ubfA13K/0fbPPe760BKtmumCZS1XeNXB53c9PEYKx57vMwM6A9TYvSeKxbwG6VM4DbSLK26Baby8R7jBXWpqC9UblcwQZtbR8eIo4sOmyZlktk1eurWXqv4DTIpNuHKeLXkjGyI10/+oh81/EPX20TeDa1gB9ljpnsrdY0e4eQ2oXM+pPbx2ZYPbD7AgSsXNcOTijveI924DbUxgUSLLnRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qozXyHGbIkZly3m4typG31QMKWhPyyFo2i1EfbYxFc=;
 b=SV0uBXwOluROo0CrOB5Y53EIn9sJ3kYmwDBWNtu25g0AZGDURUy8umPGTdAWWuELLIqvHAfoeA3HJyMIuILD5/lFKu0yQ1sFw8ONA4yybORmvD7IDvrKGfRsduKKIqOlC9sUVUW5eEcpMIVM+yckkrsVwEDB+IFidmYezu1ChzQWnxX91ziF51NPYdGXzlYUtzebdNSjsoouwapWyFFsyDYbWCCbhYDZjomZG///w9RZ7tkRyelNFDWIXlvmir0DOv27KwlUiPKh9VVu2kaqeano2kZh5s5IrGsJ0XqbxazIcNi4cwuPytizoPqckJqsTuaWFnjhAzymQUo04HpoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qozXyHGbIkZly3m4typG31QMKWhPyyFo2i1EfbYxFc=;
 b=nY4xVkcJU4QqBGf6N+8Qaue8JLuL2zv8J2GoOSNcwiAXa/SdGPNbHwypeCJ12jUnSiwDoOX/uJd7EChYbPuBmCMwWHsrkQRGV3wIzJlSgyEXYOMdB4oQefypQ/nBL2x3OpEuCFJMWlEBA8U4XRcEp9Ohvgnc8OX9kr98X/t2yAs=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 07:35:39 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 07:35:39 +0000
Subject: Re: [PATCH v5 2/4] fpga: add FPGA_MGR_REIMAGE flag
To:     trix@redhat.com, mdf@kernel.org, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210625195849.837976-1-trix@redhat.com>
 <20210625195849.837976-4-trix@redhat.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <17e69761-9922-b3f2-5bd7-e29190f0b72c@silicom.dk>
Date:   Mon, 28 Jun 2021 09:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210625195849.837976-4-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM5PR0701CA0071.eurprd07.prod.outlook.com
 (2603:10a6:203:2::33) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM5PR0701CA0071.eurprd07.prod.outlook.com (2603:10a6:203:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Mon, 28 Jun 2021 07:35:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aee807e-cc72-4cdc-94cb-08d93a0753a2
X-MS-TrafficTypeDiagnostic: AM0PR04MB6788:
X-Microsoft-Antispam-PRVS: <AM0PR04MB67882156D40547A425C4CA05D5039@AM0PR04MB6788.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyYV75RRv0ApfdaOS4V6yK8Dwfw1/gL4l1scD2unMCu752AFMgh3AISFuMijP6C0PK4SwfJ8q6gkhlUmS23cuL/QaCY2YwlXdIcUO7SXtgeWEkUK88235RQsLYP82QF6mkOsecegrvyxVER2deGhZQ5A9Vrn2FvDX7r6ceIUE0jHh/VWV0eFN83bkyVaKi6jfE7dOIp5g7guKW1DT3f+wbuEdApsxHMafjJcBQDH6T/UK2RfNcrQ6Oz64ZO3OL/6TXHLFXw7+IKG6tnY5H3yhj8yctggjmLGZYfyD3BwESMSG4Lhll+7WDd71aYd5oBZBBPWQ9GxaAK0yJSSqGxheFtd4oH41wd2VMsc12aHArf7QwlV5BGcvaFNCJt7BRegcIm1XETrsIfCo/D8IZmyx2ZISmCFXyeFoghQIHQozP+LxywKR/YEomQRZy6VIMGKjUojtj5jsyDsTU7YsQ/ZAQWflCPm290RsSlyAOEM3suj5383ouij5/DazX2o1Q+rY2qrl85ivsVOxdPPK7AUgY9WNKAQPLFqANs6Po4ze0GXvFTM/jr5BjErMWfzYl3lCEhwS9Cx3+hGSYlottBUJyWRxG4hQJ4IGQ0KLmwMqo+slbDBx1rT4WSQTF8psl+V5PaHuZ4YhTsy4qS19TTzqd2aDFDSS9V/ehqae/WkXngAFiareY0HnDKpJn0v8L2W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39830400003)(366004)(376002)(346002)(31686004)(8976002)(2906002)(8676002)(2616005)(83380400001)(956004)(5660300002)(66476007)(31696002)(66556008)(4326008)(478600001)(6486002)(38100700002)(16526019)(186003)(8936002)(86362001)(26005)(16576012)(36756003)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxrVmxMZW9nR3VpMGloa2cxUnlVZzkvU3FEWkdBbUM0Y05yK0Q4ZzQrVkc1?=
 =?utf-8?B?S3h3azNpYm9vOWV3RmFXY3NoRnhhUUNEZGJvNWRrQWZDb211OWdwSTA5dXhH?=
 =?utf-8?B?TDFhWEozMW9Rd1RaaS9JOXQ2Sk43aFIxSFFCVURHYlIrRk1DWHFseXRIWmZ2?=
 =?utf-8?B?V3pud2NaU25UMHpWNklWYkovVy9OZGw5M3JqdVVjWFgrTFZCZXh6NkxoUlV3?=
 =?utf-8?B?QURTZFMxVGczeXhBT240MHA3MlBJanBuYU8ycEJzckR6M1F1WG9XZTVsakNp?=
 =?utf-8?B?T1FsSGo3NmNEQXZRV0l1TVFmV1M3amExNHkycEVkTWlQam1BeWRwQnBITzBO?=
 =?utf-8?B?UGFUbjFzb2tPelNHQ3hCUWNPdHh6R3hybHE3c21NcWN0eUxjU2lHSFB6dGp6?=
 =?utf-8?B?ZFozYWZxdXlDaHZLNHFZZ2s1ekpTd1NONjRTOTgvSFVsNUhRZDczTjhjbHhm?=
 =?utf-8?B?WHNqbkdkZG9IaGRJaFVrMjY4U29zZWFOdTBzVllQVDViUDdQZ0M5dUhjZmxq?=
 =?utf-8?B?MFRWRDRYYXlnaG9NU0NBdTVnTC85UnNpK0RoY25CVko3SEtndFp6UkFhWVVQ?=
 =?utf-8?B?WU93Y3ZsUjNLVDkyRTJSVUlTcExNOUdya3ZRUERmdmFOYTJpenp3U1R6SVJ0?=
 =?utf-8?B?LzI1VDdrNE12RE1RaThObEgxbVNpUlhJN1l3RW0xRTYrVFlxTHlXTlROdmFu?=
 =?utf-8?B?dEF4bEhCYmVCOWdKWEkrMmRHNm9rT0tGVEZSTm5xaDFxaURkbDBXMFNheTZ2?=
 =?utf-8?B?UEpJYXZsYy9YcDNnbHJFcUUzTURsN3FrQzFwYys5UVVGdDVEYW9mNHJHaDNw?=
 =?utf-8?B?c0hQeUV6bXhNTjBhV1dlWksxQXlzREZlRkN1b3ZrRkRKTkgwZStINFZZZEdw?=
 =?utf-8?B?UG9oZVI4Tno0TnFUTFNjNmY3YjRrRzJBSzJVbEkyZkRGWngwWkZwZmJMTlJh?=
 =?utf-8?B?b0JmMHFuTDFEYjF3UnlZU0I3MFJMYmIxUG1zNGFoT2VTNkVmTFVaQmZTQUlS?=
 =?utf-8?B?UkZXRHFpUVBtUVY3UHJnM3dKSlVpWmpVa2FlZ1BDSVBBSzB2TFNnakI2L0I3?=
 =?utf-8?B?ek5oN3VIMWsrL2hYMUpTUWQrNEtIQTBvQTY5M05HWGFUYkFCRldnS21Peldq?=
 =?utf-8?B?SThjQUlqbE5UN1BXTVFDQTB6RFBMcmt0ZjhmUEFFNjhjSnpBTE1lUDZGNDFR?=
 =?utf-8?B?NHhidHJVT3hWSC9oUFlodnJkVGtnWG9vM1YrSXRHNWJkd1pVVnkrNzhyenFh?=
 =?utf-8?B?Qld5czlXd1NiRTMxZitQbFMydVhTcitvbTIrM1VRUFRnQlh6Zi8ydkppeHp5?=
 =?utf-8?B?bHNSNXhYMTI4S1lDbnpqaXlLalFWMnFIZXdHUGtubWtLNVVGK0ZqQW1xWDdo?=
 =?utf-8?B?aDI1Y3ozWHQ0aUFURkx3blpldzU2Y2M3b3hrdVFPekRYL2dGTzVSWjZsUlQ4?=
 =?utf-8?B?OW93RzZyWlJNbVFoSFBINnVNbnc4cVcralRBaHlGdVdqakRTcmZFcnAybVgz?=
 =?utf-8?B?bG9iNXN5c1ZvOGVFdjYxalUrNWdrUDF2L0lPeHZFaG1NSko4MkZJUmNGalBN?=
 =?utf-8?B?NzAxbW5QRUFKdmtvWVpMTVBDNlorYXpXMGtPVmhqZzA3OG9OSkF0bG5EaEZy?=
 =?utf-8?B?Zk9qNThFZ3YxTU9WbDRDa3k3QkVLVm1QbzZ2RTRMRVJQc3FtR0dNakdYZ2d5?=
 =?utf-8?B?Z2xhOUk4N0ZWc1JSdDRtbGo5aGVUWityQitkckdqNVkrWlpZWkp2cWpMYlFV?=
 =?utf-8?Q?012lUBmVrma4CpCuGlNZ86Hx53h5GGQ5hMJuaTx?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aee807e-cc72-4cdc-94cb-08d93a0753a2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:35:39.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xjijVED1Ky0A92sLelwKTZYs+qpUaAOGb6OxBMjBurXrDFUvzowCvIaVGaFovHe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6788
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 25/06/2021 21.58, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> If this flag is set the reimage ops will be used otherwise the
> reconfig ops will be used to write the image
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   include/linux/fpga/fpga-mgr.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 53f9402d6aa17..0791e22b07f88 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -67,12 +67,15 @@ enum fpga_mgr_states {
>    * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>    *
>    * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> + *
> + * %FPGA_MGR_REIMAGE: Reimage the whole card, fpga bs and other device fw
>    */
>   #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>   #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
>   #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
>   #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
>   #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
> +#define FPGA_MGR_REIMAGE                BIT(5)

Are you mixing spaces with tabs here?

// Martin
