Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDF2BBE4
	for <lists+linux-fpga@lfdr.de>; Tue, 28 May 2019 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfE0WJt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 May 2019 18:09:49 -0400
Received: from zangief.bwidawsk.net ([107.170.211.233]:45664 "EHLO
        mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE0WJt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 May 2019 18:09:49 -0400
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id F094812340D; Mon, 27 May 2019 15:03:13 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zangief.bwidawsk.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-1.0 required=4.1 tests=ALL_TRUSTED=-1
        shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from mail.bwidawsk.net (c-73-25-164-31.hsd1.or.comcast.net [73.25.164.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id BD0021233FB;
        Mon, 27 May 2019 15:03:12 -0700 (PDT)
Date:   Mon, 27 May 2019 15:03:12 -0700
From:   Ben Widawsky <ben@bwidawsk.net>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     hao.wu@intel.com, atull@kernel.org, mdf@kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl: afu: Remove set but not used variable
 'afu'
Message-ID: <20190527220312.etjg7efr2uekvtqh@mail.bwidawsk.net>
References: <20190527153755.7332-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527153755.7332-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 19-05-27 23:37:55, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-afu-main.c: In function afu_dev_destroy:
> drivers/fpga/dfl-afu-main.c:529:18: warning: variable afu set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in commit
> 857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Ben Widawsky <ben@bwidawsk.net>
