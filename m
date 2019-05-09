Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603BF1941E
	for <lists+linux-fpga@lfdr.de>; Thu,  9 May 2019 23:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEIVIf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 May 2019 17:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfEIVIf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 May 2019 17:08:35 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485BB21744;
        Thu,  9 May 2019 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436114;
        bh=sCSJW4L+jW24WQtgsiOwsXAfMZGt0TM+PpFkjDAxiy8=;
        h=From:To:Cc:Subject:Date:From;
        b=lN1hWcH3JBjYgvDEt+ITMWB9vh3gBw4Cl+tDwBBc22IrQ0sJ+pZSh89OlTZo8rlbr
         uM3Ro+4qefgMc3arC5xj5S0J978f50ojSh2xodQEXD06s8PA3U5msbwEOeHt6X/gcl
         AEDdxzOplEhAu9MCsHIOGxrD7gO9xg5hJKEJbsIg=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 0/4] patches for FPGA
Date:   Thu,  9 May 2019 16:08:25 -0500
Message-Id: <20190509210829.31815-1-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

Please take these four fpga fixes patches.  They
have been reviewed on the mailing list and apply
cleanly on current linux-next and char-misc-testing.

Thanks,
Alan

Chengguang Xu (1):
  fpga: dfl: expand minor range when registering chrdev region

Scott Wood (2):
  fpga: dfl: afu: Pass the correct device to dma_mapping_error()
  fpga: dfl: Add lockdep classes for pdata->lock

Wen Yang (1):
  fpga: stratix10-soc: fix use-after-free on s10_init()

 drivers/fpga/dfl-afu-dma-region.c |  2 +-
 drivers/fpga/dfl.c                | 22 ++++++++++++++++++----
 drivers/fpga/stratix10-soc.c      |  6 +++++-
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.21.0

