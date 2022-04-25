Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9165C50DA29
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 09:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiDYHd6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 03:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiDYHd5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 03:33:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0AABF4D;
        Mon, 25 Apr 2022 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650871853; x=1682407853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyJ/12LA1ncVAuoCLwsnDotLhmcJHCjxn9yopJR0sTQ=;
  b=T5zau/F47a4IACrejy5YjiU/f4+KGN4QDQrZeuhJ8+G/dM6QN0jGeCIc
   ejZo8w+Qt1fM68+U4R8nfayiMN6SQTORDI6RG/AgdMoC/eO+TZa/Vp2u4
   H408fLZFJ3tPy143GEqBzb2Apa3+7hs9sTeLj92o4R9YZbnIrWowMKnlk
   rQpPZga6VGZXZubmXybXqxmhpc2XlpdOSJ4Wd4HE9QwF65O2J8pUVaG0F
   1OHkXLcX8lroxDs3WiJzMum45F8RT6ZZVXImSM1jOE1g5hXUPS4ACXeNo
   bPWElcqD1SREmD0uXrhSfgnKmY5bvXOIBCbhCuzVsRWquU/x6mYCJQPwB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="328107422"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="328107422"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:30:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="729594460"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 00:30:49 -0700
Date:   Mon, 25 Apr 2022 15:23:07 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v7 2/2] Documentation: fpga: dfl: add link address of
  feature id table
Message-ID: <20220425072307.GB363795@yilunxu-OptiPlex-7050>
References: <20220419032942.427429-1-tianfei.zhang@intel.com>
 <20220419032942.427429-3-tianfei.zhang@intel.com>
 <YmFudmiIRh5RHGQ+@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmFudmiIRh5RHGQ+@archbook>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 21, 2022 at 07:47:18AM -0700, Moritz Fischer wrote:
> On Mon, Apr 18, 2022 at 11:29:42PM -0400, Tianfei Zhang wrote:
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> > 
> > This patch adds the link address of feature id table in documentation.
> > 
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> > ---
> > v7:
> >   - change the title and git commit message.
> >   - add Reviewed by from Matthew Gerlach.
> > v6: fix documentation from Hao's comment.
> > v5: fix documentation from Matthew's comment.
> > ---
> >  Documentation/fpga/dfl.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index ef9eec71f6f3..15b670926084 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature driver with matched feature id.
> >  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
> >  could be a reference.
> >  
> > +Please refer to below link to existing feature id table and guide for new feature
> > +ids application.
> > +https://github.com/OPAE/dfl-feature-id
> > +
> > +
> >  Location of DFLs on a PCI Device
> >  ================================
> >  The original method for finding a DFL on a PCI device assumed the start of the
> > -- 
> > 2.26.2
> > 
