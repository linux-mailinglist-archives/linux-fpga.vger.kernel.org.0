Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334492BC2D3
	for <lists+linux-fpga@lfdr.de>; Sun, 22 Nov 2020 01:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgKVAP4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 21 Nov 2020 19:15:56 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:45195 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgKVAP4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 21 Nov 2020 19:15:56 -0500
Received: by mail-pf1-f179.google.com with SMTP id b63so11447118pfg.12
        for <linux-fpga@vger.kernel.org>; Sat, 21 Nov 2020 16:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8K7iQGo4yv61l3g+o2fIKjS3QOtid1WNIFRfBk5mzoo=;
        b=esYzUmOKS3ieRV0X0SQaKzKEVbf9FyK5wSyj2vEe2RMeoWV/lkCvbClH9LFbLLyvMG
         JgyN/5xnLmWShSe1mKFhRJj+Jw2y4h0rFFeeLfDUIKbyWaEVmvAwQzhbHA+faaTrlpNF
         nyy0kmu6zVfatU3A5scDmv0y5e8NaKQmPZ2s5Kf0VcRg2nOqPF9Ki1xBe3yw/B6LV6/H
         ug4RxHZZYeB6b5gCNZLHSd8rXEKvJeWDr2S7eRXselTRj+AJcsNVCgsnMYNMRDFVlPDo
         TzOa3SyDZYlgjZZ99TwB6XtAF+fv0jqg32FIPCzvD+1IJVhxcWuGb8LugVc9+qg92+hy
         pGIA==
X-Gm-Message-State: AOAM532AxjaAhESkzD+X06uTgibQAvge9RJ64oQb8Rxgo+2UqJ5BRHen
        Bfl37eqQNbpp1Hln5v8H5Hc=
X-Google-Smtp-Source: ABdhPJz1HxrBZJwwAaLKP+mQK3J9BSx8TPbCkxxYTnwbu75vUGohH7s4LUR26CYP61ildr4pU3DiEg==
X-Received: by 2002:a63:780a:: with SMTP id t10mr10793860pgc.377.1606004161586;
        Sat, 21 Nov 2020 16:16:01 -0800 (PST)
Received: from localhost (c-73-235-149-126.hsd1.ca.comcast.net. [73.235.149.126])
        by smtp.gmail.com with ESMTPSA id c8sm9051399pjd.13.2020.11.21.16.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 16:16:01 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/1] FPGA Manager Fix for 5.10
Date:   Sat, 21 Nov 2020 16:15:48 -0800
Message-Id: <20201122001549.107023-1-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

This time as patchset, as requested last time.

Please take this fix addressing a missing dependency FPGA_DFL.

Thanks,
Moritz

David Gow (1):
  fpga: Specify HAS_IOMEM dependency for FPGA_DFL

 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.29.2

