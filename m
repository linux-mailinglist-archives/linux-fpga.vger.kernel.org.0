Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524504F8C9E
	for <lists+linux-fpga@lfdr.de>; Fri,  8 Apr 2022 05:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiDHCWR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Apr 2022 22:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiDHCWQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Apr 2022 22:22:16 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324F29B125;
        Thu,  7 Apr 2022 19:20:14 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id r66so6580217pgr.3;
        Thu, 07 Apr 2022 19:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77mGg9AZzzqczjvRh5VdTdYWN+BZWlxGZo/4aro3IbA=;
        b=C0W5jFpqbsCHD6fzciuzNE0xLQNGoxDZjEL52AbsPqV6Fvs75G8FtP45yTg2yXB3Bm
         sZN5ol6GlrKlA0Yeju0k6WR9x65sOyvn80/D9CKh5M/RDtmyhUGdh/d93yx3VoX2fbRO
         zUhJYSdPJI6wVkorKr1lnrdzrMuKWANQqAsE6DAXO6EQ+3sDvguTlFykbjUnZAn8E/Y6
         rJGEhKmvBkb9mh3G80ssXYn/9lYTk7mEdCRVd2lTNqxGvgDkUPZ1CIyWNhZ13vygYc1R
         K2vEehS5OlmwwWNkl2bTj1+xilkFq6eOc9zSBjo+QXAGflPken0LhOWXm5KQRLFBKCQs
         i0yA==
X-Gm-Message-State: AOAM53097dlsNjlqcf95Uo97BsiyBJhgzeF4if20X4RnXCwZBPdsh7By
        C0Zaj8jZ22WrfwwS8TA+/+BfRr+2g62fOQ==
X-Google-Smtp-Source: ABdhPJxfE5RYEw2y7dLVBmffQG46S+AhGteS4uO5VMNPpZ49YvdYkUK+Sc5RCvEIJVAn5Iy7qfIAPQ==
X-Received: by 2002:a63:6c0a:0:b0:398:6bd2:a16a with SMTP id h10-20020a636c0a000000b003986bd2a16amr13792858pgc.191.1649384413667;
        Thu, 07 Apr 2022 19:20:13 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id br8-20020a056a00440800b004fe10df2d3fsm13744876pfb.157.2022.04.07.19.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 19:20:12 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: Update linux-fpga repository location
Date:   Thu,  7 Apr 2022 19:20:02 -0700
Message-Id: <20220408022002.22957-1-mdf@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As maintainer team we have decided to move the linux-fpga development
to a shared repository with shared access.

Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi Stephen,

can you help us update the linux-next part accordingly?

Thanks,

Moritz
---

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..9b08d5ea001e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7717,7 +7717,7 @@ R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git
 F:	Documentation/devicetree/bindings/fpga/
 F:	Documentation/driver-api/fpga/
 F:	Documentation/fpga/
-- 
2.35.1

