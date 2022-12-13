Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2A64AF72
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 06:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiLMFsZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 00:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiLMFsW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 00:48:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BA5FCC;
        Mon, 12 Dec 2022 21:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670910501; x=1702446501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w6volb3O+OcaI6PQOEDGNu0O+6CGT0a131Nd+zZOpLk=;
  b=UOXxPTlwlgFWlbuNunp8cjgsCIJDYZgIy/lmZH7OTzOJUbSGHp5xlqWN
   wQXBei7TiubUC9GjRNiEpsSnXs3tdQ+ae4lsxaitBiI9rrphJOQa8wzNo
   Sj85tA4Tke19KOkTUur2TA8N8TVrdig/Qev1JwX01I8dJB20C4e8nwraW
   MUwsKxW1sgtEcocq4XjLCk9H9a49J0aumv2Bvv3uVHCSaIzPuXNhLHGLu
   383qXyzIRZ1dtxHkSCPAXCxlOErn8ZanajdUq5Fh7uao9EveQpAl7zS7m
   4QtxoD+GXtpnc3eruYBtd/FSAguUROD5GxLpuBs7ZqZTRPvIBTIjGwPAL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="380255027"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="380255027"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="893782221"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="893782221"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 12 Dec 2022 21:48:02 -0800
Date:   Tue, 13 Dec 2022 13:38:11 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] mfd: intel-m10-bmc: Support multiple CSR register
 layouts
Message-ID: <Y5gPw0NBA6CbD9JK@yilunxu-OptiPlex-7050>
References: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
 <20221211103913.5287-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211103913.5287-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-11 at 12:39:09 +0200, Ilpo Järvinen wrote:
> There are different addresses for the MAX10 CSR registers. Introducing
> a new data structure m10bmc_csr_map for the register definition of
> MAX10 CSR.
> 
> Provide the csr_map for SPI.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
