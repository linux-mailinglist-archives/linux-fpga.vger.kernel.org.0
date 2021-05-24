Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3054838F184
	for <lists+linux-fpga@lfdr.de>; Mon, 24 May 2021 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEXQ32 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 May 2021 12:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbhEXQ31 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 May 2021 12:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=BCvu5nDE7KgwG6YUJMSgstsNOzvNBVSrL0+h10MFEIa6uCJohu+7y+AWhJkQAoCca3PDAp
        xF/i/zU7seRIBFNfSOD4WU10/ITIVNFeUwBfgwFJhi25dQ99lFjfGhC9w3JsGwmNif0lUo
        ZBv8WuG7CUuYXhYK44JLePzdpprvjOE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-U-62lUynNh6flueq1yS80w-1; Mon, 24 May 2021 12:27:57 -0400
X-MC-Unique: U-62lUynNh6flueq1yS80w-1
Received: by mail-ot1-f69.google.com with SMTP id h8-20020a9d6a480000b02902edb9406104so20103528otn.5
        for <linux-fpga@vger.kernel.org>; Mon, 24 May 2021 09:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=aNCC3Avxi7E4qM0dn+Vbyxk85P+YSn5HinXn0zA5oRQwAIHxBDSbxFcZkGjsIRD1A9
         kRh7QvuTYigPEtvWHwH7A4c69KzoZVlY5hDz6ryAXOgWIkdFQVKxa9o4W4sISADpoG4M
         T0jpeoWzrLuXIzpTc6OC2yx+P5iswkdQAnj92hi5Vk1G+44rKdJ3lgbmH1cOQ6FjU4U7
         q/+I6g54cCpwBD+KXKuYnmMiFLWQQ3ne8FK7+3p69LhGP3lijjUwIwtwIqFpGN3aVNeM
         gNR/fqMYsQgM84XCaoYg4TUQgl5KW8P3mHMOximV2fHFLE3ZmgRchdHhsFuca8faZzV9
         pvsA==
X-Gm-Message-State: AOAM5335ofjESrCqpHHbl/LbsQfXmiFUwpgGKY+3WiPnbz9aosZpdWXA
        h3wC6aJ0JycJiuMXZt4c7sQv0hcVWIf8XO74YwDgpUAwOdlKNtoDK13ZnNw3q+er6bUounv6Ne2
        VdacIlGj0OX9ER2I/usmLDA==
X-Received: by 2002:a9d:30d2:: with SMTP id r18mr19068280otg.170.1621873676812;
        Mon, 24 May 2021 09:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/564NPCS6FnJ0OsaTxrZRw/CMSHj4jKE03KU5Oj1QWU8VWZQ5luePcELtSv05gQ3tHlVZ0w==
X-Received: by 2002:a9d:30d2:: with SMTP id r18mr19068270otg.170.1621873676671;
        Mon, 24 May 2021 09:27:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b8sm3145797ots.6.2021.05.24.09.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:27:56 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 2/6] fpga: add FPGA_MGR_REIMAGE flag
Date:   Mon, 24 May 2021 09:27:52 -0700
Message-Id: <20210524162752.2221245-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If this flag is set the reimage ops will be used otherwise the
reconfig ops will be used to write the image

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 50a9fea3c47ef..bb11b18527326 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_REIMAGE: Reimage the whole card, fpga bs and other device fw
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_REIMAGE                BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.26.3

