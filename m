Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113959C530
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Aug 2022 19:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiHVRjE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Aug 2022 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiHVRjC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Aug 2022 13:39:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC563342B;
        Mon, 22 Aug 2022 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661189940; x=1692725940;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=56J3BaFEq21EQ2evXLfHjiL1CH3IElyselRwXcR0iIY=;
  b=Vpt+L2PLRg6lqJevpjOxeSQf2WUFQYWdPfvPl9arNWVQbsbjM9qsbS59
   thdQl3IM5nSC+LHjD3hZLHW4FDXYH/vterCAKyWuqDrU5DjVp7VFTVcPU
   E78Ii/H0Jcw1DsLRzLmT0rv6TeGm1jXe2Eptj2uk9zldUU25TPlOWLEer
   dKmTncPtiaTFh74vxHl1bl4nGYjbkYyYdYi6I3SPKUkw6CnMyiPwY15C4
   WxrrzI0YrlENVRi4WjI/i3EK/9CTkc89aCWb0oLaZgJcRltQtXuYVFtdl
   yI8cJpTls03q1jzjcDwzUJehiIm5QRxmwP1TvfAYeU5buLOL5P3znz7zM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355209352"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="355209352"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 10:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="559837688"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2022 10:38:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 10:38:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 10:38:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 10:38:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 10:38:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDWSbLL0O+F29JzE9SOwG69/r3oO8U/5gjqyZ9ecy2/OuEm234kWBY7W5v1HvkPYDSivMMr+NlTkg0zkM0Bpwa2R++1HMI/h6zcMMWJ0dvmuwqrunyKvFdLn4SXneFm2k1fA/va+e52qDrbXQQEZVRi5vpvkVyUoXSnht4qzInmohR0eKMjxhhw1m3bhEORn1CMn3xKdnpJWOfNwC6Px+2RluqZ9AqS6N4gjjg18L+dpxwVg12R1V18StIbzP5VNmC12yZAuYyVZVD6pfZIsEYlE6v/vnnnV5uf16I25qlNkonvJhpyktixDNzzwFnHA0krvqv4PbiBLb5ZX5muPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56J3BaFEq21EQ2evXLfHjiL1CH3IElyselRwXcR0iIY=;
 b=CCRGtUplOaCyfVbXSXhgYGKXG8oJy+x0myLICe+uH5fZ+q78t6nNEW1K8qB9LDfmXhSXDf5T6HuvS3L3DeoVFxTG/ecwOiBjHvfia/k9jeWC8sX52NfDrypiZ1fFOCxC3+ZnrTb2Vw5Q6DCMwPCDp48ubbMCPxT86JJSL2CLaf26pgKAuuPiVnKASm7hnJZEUVE3m+FQZbz8xwLZLOdDItHnf1Bi3cWozqNdAzTolkCt3Cx5n4uhvLOdvIZqwGqkzhC5gxm2tb94slYgxJviCEx8OyrDyenrW9xIEV9XcIAeuZDjAU0Rd3giUYG0lkOLHkzA7lmbH20DFsm692Se4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM6PR11MB3564.namprd11.prod.outlook.com (2603:10b6:5:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 17:38:56 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c%10]) with mapi id 15.20.5546.023; Mon, 22 Aug
 2022 17:38:55 +0000
Message-ID: <2d608273-e37d-cb2c-45da-3213aba55f8e@intel.com>
Date:   Mon, 22 Aug 2022 10:38:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1] uio: dfl: add IOPLL user-clock feature id
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Peter Colberg <peter.colberg@intel.com>, Wu Hao <hao.wu@intel.com>,
        "Tom Rix" <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>,
        <marpagan@redhat.com>, <lgoncalv@redhat.com>
References: <20220817213746.4986-1-peter.colberg@intel.com>
 <Yv29ev8OKyEYcaf/@yilunxu-OptiPlex-7050>
 <acdf9c04-0816-5995-da90-c53153ffac59@intel.com>
 <YwMKzC6HwjYqDxIs@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <YwMKzC6HwjYqDxIs@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed69a2d6-4130-4ec4-0c3d-08da84652fa3
X-MS-TrafficTypeDiagnostic: DM6PR11MB3564:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gb5m6PcYkrPu1Zap+92pxwa2OiUI5qr7YcLbR4FGiIVy0n+QLKnVDX9imHaMC1F3m7blO+xFJ/BOAwTsQuxgBNUF/6bcqJYg2PIiA3n+wkRsc4TPh1nLPR2SB4abfg0hogCiwIz+rvwLpLN/xjv8I0BxZHOfXre9cRE2FpEs6oTXCP8BqODQYHEO+32RTG3139Ao+XZT45CiLXJkz8XAc3tW1d2sO8lEbSes9y94IVZbZp7yJPFyl38BeJzYD2+gbKrXVQ2vylmkBevBSvaLQ8zhXy8gJM/ByOSMbF7aokJ51WgtyYn/xqdEpsqqzn84ktQW5QGvcqIz/rGw+foexIRKJxMNw9tfhoyL3YkEY1C86vuNWJQDxwyE013RBeJqc6vlFjj+nZ/4w0XtElK1u6/wH/8vcXC4HL+O0PVbc8TrVslkNcJ+c+uMbsQGRi0iGnApIRq6cdz0ROAu+4Hgnr6FcfnBzerr0XtmSUErlS4M1JIAS8/kfrt4sTVhl2JfbdU8cXMepUF9YnPcxavGcR+OMb0VpFDu5mryXUL+upLD5cCjwv0hk943VuFbzL+b6cjfEnUTBCvw+9GJbDI+kubfzwmaOpDVS2khe2vVJ/rrkkixYNlV6JFc+NuwksRA4ASWloibQ7FmS+Te+ljG0Qk+QAXgdXE7P3gEbxZXlvSSiJaeizbUisejbQGzViEhYc22h6UtATKw5nlOq6dZruIuiJ9oYgUUCguD3Z/59W4XN4fPhRjwCum/zlFcPPrgcFe+vOIXoUPnOC5lOSfnnkRf9uMVIGbqfptirzE0rGLRd+o09LCfpxblTTXbo06Hx8DuVRKakm+AAu249kNmwp0fwI2ZhDoIe/qDjhUhE5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(366004)(136003)(82960400001)(86362001)(31696002)(38100700002)(316002)(54906003)(37006003)(6636002)(966005)(8936002)(6862004)(5660300002)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(83380400001)(186003)(2616005)(478600001)(6486002)(41300700001)(26005)(53546011)(6512007)(6506007)(6666004)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9VYkNzQXZLSWlXcFduUFdieTNaRmtvc2lQeEV0QVkrc25WVUUzMnROTVRx?=
 =?utf-8?B?MFZDcVVzWWh4V01lVmtnaGdRYkJCT1ZrZWt6bUExZStOV0RHb2pLWlcyelJU?=
 =?utf-8?B?SGNldFZISFgzWDF5ZmU1TlgvU2ZwcVRkUUNKdm1LenpkYnIwa202UGNQM2lB?=
 =?utf-8?B?dWJqKzhIV2wxSTVSdGdhaGNHWlg2RFcwb0o2N1p2b2gyVGNkVHNaamdkSW9l?=
 =?utf-8?B?NHVBTkZrejlWOHhaNnYrdUJ2V2x2emZoWGVMMGNzUm94ME9ua2JScVZxeUNs?=
 =?utf-8?B?Y2lWeG1PWDJOcFNiOWhwVWdlNEpwVGJjbGlBQTVzK01oL0RDMk5tK1hzdE9T?=
 =?utf-8?B?Nk82bkdlV1FOYWh2SUdEYVozcFR6UDQ2SDZGU3VLYzFidzR6ZmRRTTVpalJF?=
 =?utf-8?B?Z3MyMXBUQmNnQ0I5TmdyTXo5cmN5TzNDL3FEWC9tQWx5L2twUW1QTHlDd1Fw?=
 =?utf-8?B?T3Z2aEJpYVU5WUtHYnlGeFBhZlRvK245K0Q1M0JsMEZwYVk0c1B5aW15aUFt?=
 =?utf-8?B?TGFVWmh0TzJGRlpPQ1JsczhwV1VpcTRVSVM5TlFLSFJJNHg2dWlFWm1uMTFP?=
 =?utf-8?B?cW04L3c3K01JUGFjQnNNWGVLOUdwdDIycTNxQjNaNEtQWU9uNlFubWJ6NEhw?=
 =?utf-8?B?aUNiSnphdmJiUGxLRFB3L2cyUUJXejdkRDFGNEVUeDNTN1FGS0lhMUUyR3VK?=
 =?utf-8?B?NnVJQTdyQUc4cVJya3REbG1rR2daOHU5TVoybWJmUkE5SUJ1RGovcXFtWW4x?=
 =?utf-8?B?MFF4SHVQSEIrNTVJN1FxV0lCVjBjNklNM0xuVjJjaEVROXlocDNja2g0bzhH?=
 =?utf-8?B?dXBVdy9rcW9LVEgycDhYMmJBWFEvV2NCWVBEOUJoTGJmem9kdUd5NVpEOTBv?=
 =?utf-8?B?TmtHQ0tXK3dseGUrTndKdXdob0RlRlJCUTVocm4wQ1Q3R1hKOGkzaXRmdkxa?=
 =?utf-8?B?RHZFMzlHUXA4WFE3bUFMaHRHeE1BeTE2MXFLdnFRUlNhRzQyMGhXMW41V3F1?=
 =?utf-8?B?WmcwRlYyOWY2dGFPOFVCYk5HcVNxNjNoRjR5RDd5emw4M1dheGpPQkxGQ2Q0?=
 =?utf-8?B?dDRNak5lM01DRHdzenp0ajFlLzQ3U2FZYnFEaTA1QmlVbVgxeGtKYU5ydFYr?=
 =?utf-8?B?RTFHVys2L2dBSGY0TWhDU1lQd3RBb1hwS01rQmJ3MG96NHVhU3FvUTArTzQ3?=
 =?utf-8?B?Ykk5bCs0Ymt4anNkT09BdWtxQkczVnRjdzc3clRma01CYkFEaTNmMHQwQ0hl?=
 =?utf-8?B?Q2tvZG5TMXFqbDN0VEE0Q0J2TklBVUlFa0ZLVjB3L0JqaHNyUUc4cE5GMkU2?=
 =?utf-8?B?ZXBKbWhSOGJZWFJndU5jcGpXc0FGd1M4ZG5xdlYyekUzWDlNMGl1Tzl4bW1J?=
 =?utf-8?B?VTNIY29LbXdGUEV3VUhycm1zRGlQVit1TVRudWdtSCtuOHM0RGZmWE9OU1Aw?=
 =?utf-8?B?ZDdFc1dOY20zWWVmdDV5d3UvL2dMVlJ6MU1TOEt2a3RnSjFLWUIxWDArTUNU?=
 =?utf-8?B?MDZENGRJQ0lFQW01aXJ0WjZwWjlGMVRhM3lLVkk5ZnA1V0NoVVRHQmdrbzZx?=
 =?utf-8?B?MWtFMUxKZkttWCs1N0UvMkxieEExYUF1RWVSSGE1b2Q5cTJwcEliRGdSTGtY?=
 =?utf-8?B?T0YveFFSeDRhdXhhVXN0QWtCckozOCticUlCTy9WTXVyKzRSN2paL3NYUi9s?=
 =?utf-8?B?d3ZzYXlBeDdLckROeTN5TTZ0L005bHF0Y1pTc2t2b0dCL2t6a1VlYmdkTXNY?=
 =?utf-8?B?OXcvbmNjSmdNSjNEUi9ZaGdic0thRHgyNlo3di8yamtMSnFodHVJVFdWdVdB?=
 =?utf-8?B?OEgxNWJnL1hibExCbkNia0kxS1l2Z0lBd01ERUJPRk1La0RkOVl0TWcwbHZy?=
 =?utf-8?B?dTZGMThvZFBCMEc5aFhIQURqMjFMNHZVLzRHbS9ZZTFnVDhoNTc1RzFzZTZn?=
 =?utf-8?B?NFNtMFRtV1Q1UGFCL1JKMVJhSE9VZnJiYTU3Q3g4Qy9kUTQ3b2t1WHkxYjA5?=
 =?utf-8?B?djBsaDVnRHFkN3lOd2h1RUNxWEJ2bVgrMXM3K2ExR25LeDE1Wlh2VFAxR2Z2?=
 =?utf-8?B?eDRiQ280MWoya3ZuNEhUL0pxenZGNzFNUGxST1JWNFhTQ3BHaGU2WitZWllz?=
 =?utf-8?B?S0IrRWJqSUtvbkpLdjIwWWcwUWdrSmNPS1dQRUV0YkZEL2Q0Q0dkZDJ3Ym1Y?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed69a2d6-4130-4ec4-0c3d-08da84652fa3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 17:38:55.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMvs93MYFD5++MSUSBye8hDmNTj8eMud86mNvKQTPFr/UZB2TWFL6JmC/xU1yAJd5TdtTg/KMQm77kE8P59pfGjhsABSojMqhPAn0Ji7pp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 8/21/22 21:49, Xu Yilun wrote:
> On 2022-08-18 at 17:38:35 -0600, Russ Weight wrote: >> >> >> On 8/17/22 2=
1:18, Xu Yilun wrote: >>> On 2022-08-17 at 17:37:46 -0400, Peter Colberg wr=
ote: >>>> Add a Device Feature List (DFL) feature id for the >>>> configura=
ble IOPLL user clock source, which can be used to >>>> configure the clock =
speeds that are used for RTL logic that is >>>> programmed into the Partial=
 Reconfiguration (PR) region of an >>>> FPGA. >>> Why not use linux clock f=
ramework for this IOPLL? And let the PR >>> driver set it togeter with the =
RTL logic reporgramming? >> >> Hi Yilun, >> >> We previously explored the p=
ossibility of plugging into the linux >> clock framework. For this device, =
setting a desired frequency is >> heavily dependent on a table of values th=
at must be programmed in >> order to achieve the desired clock speeds. >> >=
> Here is an example table, indexed by frequency. The first element >> in e=
ach entry is the frequency in kHz: >> >> https://github.com/OPAE/opae-sdk/b=
lob/master/libraries/plugins/xfpga/usrclk/fpga_user_clk_freq.h >> >>
>> >> >> >> >> We previously experimented with a kernel-space driver. The
>> implementation exported a sysfs node into which the table values >> for =
the desired frequency would be written in order to set the >> desired frequ=
ency. The function of the driver was to execute the >> logic required to pr=
ogram the device. We did not think this >> implementation should be up-stre=
amed. >> >> It isn't practical to upstream the frequency tables as they are=
 >> subject to change for future devices. For example, if the >> reference =
frequency changed in a future device, a whole new table >> of values would =
have to be added for the new device. In a recent >> transition to a new dev=
ice, the range of frequencies was increased >> which required an extension =
to an existing table. > > Making a table for the inputs & outputs is always=
 a easier way to > get things done, but the trade off is, as you said, exte=
nsion to the > table every time for new outputs. > > So do we really need a=
ll parameters to be in a table, or these are > actually the outcome of some=
 calculation? Is it possible just > Implementing the calculation.
For each desired frequency, the table values are produced by calling
the quartus tool, the same tool that generates the IOPLL RTL logic.
The quartus tool allows the RTL designer to select different options
which can affect the table values. For example, the current IOPLL
used in OFS has two frequency outputs and the desired relationship
between the two frequencies is 1x/2x until the 2x frequency reaches
a threshold (about 800MHz) and then the relationship is modified.

To convert this process into an algorithm would require reverse
engineering the quartus algorithm for the set of variables and
clock relationships in a specific implementation. The resulting
algorithm would have a very narrow application; we would have to
upstream additional algorithms for future, modified implementations.
Also, customers have the ability to modify the IOPLL implementation
if they choose. A table driven driver enables customers to easily
adapt the driver to their implementation.

We think a userspace table-driven driver is the best approach for
supporting the user clock.

- Russ

> > > If I remember correctly, linux clk framework enables a generic clk > =
caculation mechanism. It encourages people to model the internal > refclk, =
plls (and deviders?) separately and construct the clk tree. > Then the spec=
ified calculation could be simpler for each clk driver. > > I'm not sure th=
e clk framework fits all your need, but please > investigate it firstly. > =
>> >> A previous implementation of the user clock was also implemented >> i=
n user-space. The kernel driver exported each of the registers, >> but all =
of the logic was implemented in user-space. The kernel >> portion can be vi=
ewed here: >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/tree/drivers/fpga/dfl-afu-main.c#n380 >> >> >> >> >> >> >> This is=
 our reasoning in choosing to implement this driver in
>> user-space. Would you consider a uio based user-space driver to be >> ac=
ceptable for in this case? > > As usual, we firstly make clear why existing=
 framework cannot fit > the case and should be implemented in userspace, th=
en everything > would be OK. > > Thanks, Yilun > >> >> - Russ >> >> >>> >>>=
 Thanks, Yilun >>> >>>> The DFL feature id table can be found at: >>>> http=
s://github.com/OPAE/dfl-feature-id >>>> >>>> Signed-off-by: Peter Colberg <=
peter.colberg@intel.com> --- >>>> drivers/uio/uio_dfl.c | 2 ++ 1 file chang=
ed, 2 insertions(+) >>>> >>>> diff --git a/drivers/uio/uio_dfl.c b/drivers/=
uio/uio_dfl.c >>>> index 8f39cc8bb034..69e93f3e7faf 100644 --- >>>> a/drive=
rs/uio/uio_dfl.c +++ b/drivers/uio/uio_dfl.c @@ -46,10 >>>> +46,12 @@ stati=
c int uio_dfl_probe(struct dfl_device *ddev) >>>> >>>> #define FME_FEATURE_=
ID_ETH_GROUP 0x10 #define >>>> FME_FEATURE_ID_HSSI_SUBSYS 0x15 +#define >>>=
> PORT_FEATURE_ID_IOPLL_USRCLK 0x14 >>>> >>>> static const struct dfl_devic=
e_id uio_dfl_ids[] =3D { { FME_ID, >>>> FME_FEATURE_ID_ETH_GROUP }, { FME_I=
D, >>>>
FME_FEATURE_ID_HSSI_SUBSYS }, + { PORT_ID, >>>> PORT_FEATURE_ID_IOPLL_USRCL=
K }, { } }; MODULE_DEVICE_TABLE(dfl, >>>> uio_dfl_ids); -- 2.28.0 >>>> >>

