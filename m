Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24B26D739C
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 07:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjDEFFz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 01:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjDEFFy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 01:05:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F72359D;
        Tue,  4 Apr 2023 22:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680671152; x=1712207152;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BlYXpDFZgVPdmWEqlE/MfJmx8DZPUzt80ZPiWWSSO88=;
  b=UbiJUpCEkHgPHgSQWf83ChdTlUVutNm9A8KfWLE6k4aWIA6zkTiIe8QL
   8uEmNmuEaqPUA+TCXWEFYKXHUEXp86EEPJCjMhBLLMZabQTY+DGeSEsmY
   yA7pm4NMtJQ0VUSjSw/CbePcPmav4h6UL7YkdiM85RJcT2J6fZhZ8xmk7
   917dj7BUY4LZ1M0/b1/ygsO9VHFjzswnHQXubVKmuoFGzSgZALN72BWMN
   WN/bBdXiS/nbVat8MyhHPuHsX6F2tfn8deuZnHJu22xJnRwe2zyMyk7kt
   mZGR+PNeB+5OttbCf7VcltGV4jwaE9KND29t7inJZCMdKjQIqaD9fVYTs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="322031560"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="322031560"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 22:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755885242"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="755885242"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2023 22:05:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 22:05:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 22:05:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 22:05:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 22:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmmaVQdakt4uNrFE3B5emnbP0w34NuBKrq59UMUEHNj/ecO7FCNgpbeYkwOMf0XOVMKSDXSNEXS50otEhgkY6R0Cf8oyjh4VWLOAZz/L+I8pNZ+vgZ9mYllLmte05gVAof4TLuIJ/c/FJo8jEFzJPdxMat9NCvCvPlioFsJUYCf457pcHlGopVGyGX6phoo1QwVTTK+4neE25gTNge58+k8ePfz4XDwwqtGKz5tJIH9Uu1H28C7S5pPSVjRnw6FgeqbRfW2Swgo1CSHtL6OnKJABJJUm+jFNGYFhxjrRmdlck7SG2RkHFfEmVIMFsY3FrAhVo0DX4Nt1LLYYyeMV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4fmY5xTMzxxyOt1anyyjf6MtQAX79M8jujBRC9nhG8=;
 b=CRZc78cQbFHOgHcPhY94+MGW+3T50sxmuL8+suquiMb4HUiYydst1qs6G6OwI0XtkEqMW494oLX89pIknWtKjh3C2Fw0wWxLwZlpnROiyuX9J0dlkwwL9JT79R2uVuQvpliMUzss2LzUPsLuD/42kExI5s4KDkzc2KgCT5d438ZvgvihDSkTtN/8VbEXUpidk1jiHP5xFm5jxqu1nPbJnqhqKIGq/w21FZffVxcQytPVAZT6aNRV8jjwHSwXzKlWk0nWCRm6sWpAm35TrxWsRE3eH9kV593Qj64XlgOdQtn9reyhC0oAdzVBHjbNIgy+Sbi2tH2LRfYmvPslw7igsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 05:05:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 05:05:41 +0000
Date:   Tue, 4 Apr 2023 22:05:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Shaokun Zhang" <zhangshaokun@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        "Atish Patra" <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: RE: [PATCH 30/32] drivers/nvdimm: Assign parent for event_source
 device
Message-ID: <642d01a118981_21a8294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-31-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230404134225.13408-31-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf1198f-e225-4afe-d14e-08db35936726
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZvCnoIpNfE1kn5nbJFekjjHrL9YmKWOQhw6VRiPeBW3KRFDd3itKLxxMVyuIfl086w8oSZtAIP1AqI1kzLTYVDMMSvXJu7nwIHvrLkkPjYScsW4kUMNRwUKPbhiy095RAJAhkcYcOSHCwIf9p1MckTs/nEKSLvQl2s93oHvugY/gWXhYBuG1db8t5NqzrogkeZjcTO4uHgdLYKQSND6thXY8xg2fuhlYYl+v+0dPuZzkOOdU0uhJS01F5YdOUy6VGIx4dZV2CQfWvR594ukAoLZ9Dtr002evDIxQgE17ga1nVw4aAwmKabECWIFVZZAUjwC/uPLP5FzkgNICkgCQUiMC6wXII8RLfNl0s7GMDqqifPHCkhjtbQ6BYvVsirHqr854lH9KqKyt3WAHs4lEnR++xmT/rgw+K0ldlANYtIvWINngQAFqO9rQ9wXIbAZLvgfof/95K12Xmy8RDcrxlyDsnH83zGiJYm2HhwOU1TWUzULwIdrZxp4OtLFKDaPLNvuQTcv8aEJ8HfoCsOQTQhbNBs0VGlTiAkvYREGg6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(6486002)(966005)(6666004)(8676002)(66476007)(66556008)(66946007)(9686003)(26005)(6512007)(6506007)(86362001)(4326008)(2906002)(186003)(316002)(478600001)(82960400001)(110136005)(41300700001)(8936002)(54906003)(4744005)(38100700002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6n+m3xUfnUGUP+rrkzLT/4D1y5fKt0+iLu++G289X7V93mZDTk4RXuU2AQL3?=
 =?us-ascii?Q?EPGqE4T9dZNaE5w94eaHREfk1vGo/k3zEZJzDivTQFdpXjwAufZBIroI9Fkn?=
 =?us-ascii?Q?DQ8dkIbZOGZ3MhUIvGU/NazcfeVQ0OGYSgMi4pzNDRH9ANirjFdwzA2ZVp6/?=
 =?us-ascii?Q?412ZPKkxnBvLNZKCYmAbEvlEW8LrclLxWr0AkdCPdQGQgBeSQAxWH3agH8Pw?=
 =?us-ascii?Q?4QRONjI6c/MW/gbwYfaePjksKsjFH6VrJftvIl0WWR+6oIwyDlT5RVieb9AV?=
 =?us-ascii?Q?rMRJiPokGBHPFkvk9KQDFLHDXra+T60GNl2pP4zqGchHFR1ZKVd/3hppGGBx?=
 =?us-ascii?Q?7363d0AHEjdBedsbL85khwzLW8u/leXlADocL3WoXw1Fpw6lrLu3cGKK+waZ?=
 =?us-ascii?Q?HlUKNklY1ngmy/53nAzz1tJG23egIgjPhgOe5mKWjxinGVpRkXow4WULDZVu?=
 =?us-ascii?Q?S1GugdcLQJkgJl1xkvYO+6N8+i+yC0KmvMAysdW9z15y91U7CEM40qN4Yyan?=
 =?us-ascii?Q?Mn5CJPsxOutxYK/GrwkB8ASM5R+eiGZ7rRde0few5rBg7ht2kHNRALzsImV1?=
 =?us-ascii?Q?ztvUMiYf+fqfM8Iw01BtPhNuK+wBOSeTgHwsZ6P41bpKvHG96LdWU+x4K7Rs?=
 =?us-ascii?Q?y2EaI9OZ9Ts25cDnPTEqlYNdxo3xaeZS9rw/YS9kC7NeheKvV9iOvsJW1C2u?=
 =?us-ascii?Q?KY8tNcMv0aOV/484VVW9TVjP7BM/Qrg9ITCbTxrByXHaroxZ/LIoWP81kBlW?=
 =?us-ascii?Q?/VNDuZDpTpHebyKZmR3/QpdP06QolAsEsRwS/yzFEn3VF5uyJOlQIzjddX7q?=
 =?us-ascii?Q?kr5OCYc2L7+2dlysthcZBRYyXXASLdqfN7F+4MBrTms3bUSx3C0a6R2Z+XoL?=
 =?us-ascii?Q?XS59N+LjWLXglP7+3yVcXnD2y2wH5+n/GCUK0AahBgLtThdR9B2Vv85xCD33?=
 =?us-ascii?Q?Pi1d84ZArhSc8R6gMz8eNdKbBeLzWw5nN2c/NtXIzPH4ByHyT03+C9cj3ODN?=
 =?us-ascii?Q?XTJMqFhdpTFJLdaFMNbqHUSwdhVB/1GYWGVPaT+k7WiatJ4DX2VO8veges97?=
 =?us-ascii?Q?UDnLmImCYKiZqePuGnbYeYJwmCPv8LCjTrMIXJ1wSyY7xXj48aSmzks1ls/E?=
 =?us-ascii?Q?2PWBM5yGSzy68+r9gt1dJU2qCEgUdJe2l9Oz2l4XbRFKw4X4Wzo4gma6ZPAo?=
 =?us-ascii?Q?zsKbVKBxDVqMhJFwxPzm36xIVDpeLMVVjqDwHb0jrby9EHEkyx43qwXDGRIS?=
 =?us-ascii?Q?23QisedVlOiqejnytdvvOBMCV/9MBuWCOYbs3u2KbwNaTux+It3JI2IozZ7O?=
 =?us-ascii?Q?Oi+jiSJCCmbB8rsddq7+QOzO/a2XS8rm6MVACl+uNn3C0g0jLN8pdk0Fk00o?=
 =?us-ascii?Q?G3c2LZl7LvbTpbq+QNQgiO327UK9jslr4ZzKtdjK/iq40Rz03/l4xHSfUMGy?=
 =?us-ascii?Q?UWDXzWjARqrJ+5gnEkwrjP1pEiRDzYSqAyBo8xG+MeVnh/wSUUsBXvNeN7qU?=
 =?us-ascii?Q?uljGdYItvX5nhNgesbey/q2ytDJ7mOFMJgbCxv/HdRw25Y4HK1fjC0EZsZ3Z?=
 =?us-ascii?Q?FLLMiTRhQZdigbZA2VynAfiYQw5Wzwi7ahNiuvdDtTG6uUBnJVfzHk8sHTev?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf1198f-e225-4afe-d14e-08db35936726
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:05:41.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzG8LRgu1Mja/sEgPLWoVAPyuvp4p8JEd3fP99ZLTJWQZZ6s9YHyWq8IgZSDruVcMuBX/c1JKD3GHSo7U002esMHDuzh1HhCmbS9auCBNXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the platform device.
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: nvdimm@lists.linux.dev
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
